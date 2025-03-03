import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/utilities/cryptUtility.dart';
import 'package:frontend/utilities/dateTimeUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:hive/hive.dart';

final _con = Hive.box('dis');

String getU () {
  final u = _con.get(1);
  return u;
}

String getJ () {
  final j = _con.get(2);
  return j;
}

String getP () {
  final p = _con.get(3);
  return p;
}

String getA () {
  final a = _con.get(7);
  return a;
}

bool getAS () {
  final as = _con.get(8);
  return as;
}

bool getExpiryDate () {
  final start = _con.get(5);
  final lifeTime = _con.get(6);

  if (start == null) {
    return true;
  } else {
    bool res = timeExpiry(start, lifeTime);
    return res;
  }
}

void setU (u) {
  _con.put(1, u);
}

void setJ (j) {
  _con.put(2, j);
}

void setP (p) {
  _con.put(3, p);
}

void setA (a) {
  _con.put(7, a);
}

void setAS (as) {
  _con.put(8, as);
}

void setExpiryDate (markedDate, expires) {
  _con.put(5, markedDate);
  _con.put(6, expires);
}


Future<Map<String, dynamic>> authenticate ({ required eData, required pData, required ctx, required type}) async {
    Map<String, dynamic> authResponse = {};
    authResponse['isThereError'] = true;
    authResponse['eErrMsg'] = '';
    authResponse['pErrMsg'] = '';
    authResponse['authType'] = type;
    
    print('Pre encryption Email: ${eData}');
    print('Pre encryption Password: ${pData}');

    final String enPData = encrypt(pData);
    final String enEData = encrypt(eData);

    final String deEData =  decrypt(enEData);
    final String dePData =  decrypt(enPData);
    print('Post encryption Email: ${enEData}');
    print('Post encryption decrypted Email: ${deEData}');
    print('Post encryption Password: ${enPData}');
    print('Post encryption decrypted Email: ${dePData}');

    try {
      var res = await Dio().post(
        authResponse['authType'] == 'login' 
        ?
        'http://192.168.31.190:8080/api/login/'
        // 'http://10.101.76.99:8080/api/login/',
        :
        'http://192.168.31.190:8080/api/signup/',
        // 'http://10.101.76.99:8080/api/signup/',
        data: {
          "email": enEData,
          "password": enPData
        }
      );

      String response = res.toString();
      // print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');
      final uId = result['id'];
      final jId = result['token'];
      final expires = result['tokenExpires'];
      final markedDate = '${todaysDate()}';
      print('This is the uId from authenticate $uId');
      print('This is the jId from authenticate $jId');

      setExpiryDate(markedDate, expires);

      if (result['id'] != null) {
        setU(uId);
        setJ(jId);
        print('This is the uId after I set it up in authenticate ${getU()}');
        print('This is the jId after I set it up in authenticate ${getJ()}');
        // print('The setup works');
        authResponse['authType'] == 'signup' ? nextPage(ctx, '/pin') : nextPage(ctx, '/epin');
        return authResponse;
      }

      return authResponse;
    } on DioException catch (e) {
      final errorMsg = e.response?.data;
      // print('Error: ${e.response?.data}');
      // print("This is the type ${errorMsg.runtimeType}");
      // print("This is the type ${errorMsg['error'].runtimeType}");
      //this is from the prev sign up
        if(authResponse['authType'] == 'signup') {
          if (errorMsg != null && errorMsg['error'] != null) {
            authResponse['eErrMsg'] = errorMsg['error'];
            return authResponse;
          }
        }

      if (errorMsg['error'] != null) {

        final error = jsonDecode(errorMsg['error']);
        print(error);
        print(error['pError']);
        if (error['eError'] != null) {
          authResponse['eErrMsg'] = error['eError'];
          authResponse['pErrMsg'] = '';
          return authResponse;
        } else if (error['pError'] != null) {
          authResponse['pErrMsg'] = error['pError'];
          authResponse['eErrMsg'] = '';
          return authResponse;
        } else {
          final defaultError = "An Unknown Error Occured, Please try again";
          authResponse['eErrMsg'] = defaultError;
          authResponse['pErrMsg'] = '';
          return authResponse;
        }
        //chek if there is perror then check if there is eerror
      } else {
          List <String> emailErrors = [];
          List <String> passwordErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'email') {
              emailErrors.add(error['msg']);
            } else if (error['path'] == 'password') {
              passwordErrors.add(error['msg']);
            }
          }

          if (emailErrors != [] && passwordErrors == []) {
              String emailErrorDisplay = emailErrors.join('\n');
              print('Email Error: $emailErrorDisplay');
              authResponse['eErrMsg'] = emailErrorDisplay;
              authResponse['pErrMsg'] = '';
              return authResponse;
          } else if (emailErrors == [] && passwordErrors != []) {
              String passwordErrorDisplay = passwordErrors.join('\n');
              print('Password Error: $passwordErrorDisplay');
              authResponse['eErrMsg'] = passwordErrorDisplay;
              authResponse['pErrMsg'] = '';
              return authResponse;
          } else if (emailErrors != [] && passwordErrors != []) {
              String emailErrorDisplay = emailErrors.join('\n');
              String passwordErrorDisplay = passwordErrors.join('\n');
              print('Email Error: $emailErrorDisplay');
              print('Password Error: $passwordErrorDisplay');
              authResponse['eErrMsg'] = emailErrorDisplay;
              authResponse['pErrMsg'] = passwordErrorDisplay;
              return authResponse;
          } else {
              final defaultError = "An Unknown Error Occured, Please try again";
              authResponse['eErrMsg'] = defaultError;
              authResponse['pErrMsg'] = '';
              return authResponse;
          }
      }
    }
  }



Future<Map<String, dynamic>> dotsAuth ({required dotString, required ctx, required type}) async {
  Map<String, dynamic> dotResponse = {};
  dotResponse['isThereError'] = true;
  dotResponse['type'] = type;

  String j = getJ();
    String u = getU();

    final defaultError = "An Unknown Error Occured, Please try again";

    final String dePData =  decrypt(dotString);
    print('Post encryption decrypted Password: ${dePData}');
    print('This is the user $u');
    print('This is the json $j');

    try {
      var res = await Dio().post(
        dotResponse['type'] == 'setDots'
        ?
        'http://192.168.31.190:8080/api/signup/assignPin'
        :
        'http://192.168.31.190:8080/api/login/confirmPin',
        data: {
          "pin": dotString,
          "id": u
        },
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
        },
      ),
      );
      

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');
      final _uId = result['id'];
      print('User: ${_uId}');

      dotResponse['pError'] = '';

      if (result['id'] != null) {
        setU(_uId);
        print('The setup works');
        dotResponse['isThereError'] = false;
        return dotResponse;
      } else {
        dotResponse['pError'] = defaultError;
        return dotResponse;
      }
    } on DioException catch (e) {
      print('Error: ${e.response?.data}');

      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          //remember to change this to a session logout inplace of this 
          dotResponse['pError'] = 'Account does not exist';
          return dotResponse;
        } else if (e.response?.data['error'] != '') {
          dotResponse['pError'] = e.response?.data['error'];
          return dotResponse;
        } else {
          dotResponse['pError'] = defaultError;
          return dotResponse;
        }
      } else {
        final errorMsg = e.response?.data;

          List <String> pinErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'pin') {
              pinErrors.add(error['msg']);
            }
          }

          if (pinErrors != []) {
              String pinErrorDisplay = pinErrors.join('\n');
              print('Pin Error: $pinErrorDisplay');
              dotResponse['pError'] = pinErrorDisplay;
              return dotResponse;
          } else {
              dotResponse['pError'] = defaultError;
              return dotResponse;
          }
      }
    }
}



Future<Map<String, dynamic>> accountAuth ({required firstName, required lastName, required mobile, required address, required type}) async {
  Map<String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['fnameErr'] = '';
  authResponse['lnameErr'] = '';
  authResponse['phoneErr'] = '';
  authResponse['addressErr'] = '';
  firstName = encrypt(firstName);
  lastName = encrypt(lastName);
  mobile = encrypt(mobile);
  address = encrypt(address);

  String j = getJ();
  String u = encrypt(getU());

  final defaultError = "An Unknown Error Occured, Please try again";

  try {
    print('This is the user $u');
    var res = await Dio().post(
      'http://192.168.31.190:8080/api/user/',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'mobile': mobile,
          'address': address,
          "id": u
        },
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
        },
      ),
    );

    String response = res.toString();
    final result = jsonDecode(response);

    print(result);

    final aId = encrypt(result['id']);
    print('This is the account Id: $aId');
    setA(aId);
    print("This is post storage account Id ${getA()}");

    if (result != null) {
      authResponse['isThereError'] = false;
      //check if authResponse is true or false
      return authResponse;
    } else {
      //check if an unknown error
      return authResponse;
    }
  } on DioException catch (e) {
    // print(firstName);
    // print(firstName.runtimeType);
    // print(lastName);
    // print(lastName.runtimeType);
    // print(address);
    // print(address.runtimeType);
    // print(mobile);
    // print(mobile.runtimeType);
    // print(type);
    // print(type.runtimeType);


    final errorMsg = e.response?.data;
    print('Error: ${e.response}');
    print('Error: ${e.response?.data}');
      if (e.response?.statusCode == 500) {
        authResponse['lnameErr'] = 'An unknown error ocurred';
        print('It skipped');
        return authResponse;
      } else if (errorMsg != null && errorMsg['error'] != null) {
        print(errorMsg['error']);
        if (errorMsg['error'] == 'Request is not authorized') {
          authResponse['lnameErr'] = 'An Error ocurred, Please try logging into the app again';
          return authResponse;
        } else {
          authResponse['lnameErr'] = defaultError;
          return authResponse;
        }
      } else {
        List<String> fnameErrors = [];
        List<String> lnameErrors = [];
        List<String> phoneErrors = [];
        List<String> addressErrors = [];

        for (var error in errorMsg['errorMsg']) {
          if (error['path'] == 'firstName') {
            fnameErrors.add(error['msg']);
          } else if (error['path'] == 'lastName') {
            lnameErrors.add(error['msg']);
          } else if (error['path'] == 'mobile') {
            phoneErrors.add(error['msg']);
          } else {
            addressErrors.add(error['msg']);
          }
        }

        if (fnameErrors != [] && lnameErrors == [] && phoneErrors == [] && addressErrors == []) {
          String fnameErrorDisplay = fnameErrors.join('\n');
          print('First name Error: $fnameErrorDisplay');
          authResponse['fnameErr'] = fnameErrorDisplay;
          authResponse['lnameErr'] = '';
          authResponse['phoneErr'] = '';
          authResponse['addressErr'] = '';
          return authResponse;
        } else if (fnameErrors == [] && lnameErrors != [] && phoneErrors == [] && addressErrors == []) {
          String lnameErrorDisplay = lnameErrors.join('\n');
          print('Last name Error: $lnameErrorDisplay');
          authResponse['fnameErr'] = '';
          authResponse['lnameErr'] = lnameErrorDisplay;
          authResponse['phoneErr'] = '';
          authResponse['addressErr'] = '';
          return authResponse;
        } else if (fnameErrors == [] && lnameErrors == [] && phoneErrors != [] && addressErrors == []) {
          String phoneErrorDisplay = phoneErrors.join('\n');
          print('Phone Error: $phoneErrorDisplay');
          authResponse['fnameErr'] = '';
          authResponse['lnameErr'] = '';
          authResponse['phoneErr'] = phoneErrorDisplay;
          authResponse['addressErr'] = '';
          return authResponse;
        } else if (fnameErrors == [] && lnameErrors == [] && phoneErrors == [] && addressErrors != []) {
          String addressErrorDisplay = addressErrors.join('\n');
          print('Address Error: $addressErrorDisplay');
          authResponse['fnameErr'] = '';
          authResponse['lnameErr'] = '';
          authResponse['phoneErr'] = '';
          authResponse['addressErr'] = addressErrorDisplay;
          return authResponse;
        } else {
          authResponse['fnameErr'] = defaultError;
          authResponse['lnameErr'] = '';
          authResponse['phoneErr'] = '';
          authResponse['addressErr'] = '';
          return authResponse;
        }
      }
  }
}



Future<Map<String, dynamic>> accountSecurityAuth ({required securityQuestion, required securityAnswer, required type}) async {
  Map <String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['securityAnswerErr'] = '';
  authResponse['securityQuestionErr'] = '';
  authResponse['type'] = type;
  securityQuestion = encrypt(securityQuestion);
  securityAnswer = encrypt(securityAnswer);


  String j = getJ();
    String u = getU();
    String a = getA();

    final defaultError = "An Unknown Error Occured, Please try again";

    // final String dePData =  decrypt(dotString);
    // print('Post encryption decrypted Password: ${dePData}');
    print('This is the user $u');
    // print('This is the json $j');

    try {
      var res = await Dio().post(
        'http://192.168.31.190:8080/api/user/secure',
        data: {
          "securityQuestion": encrypt(securityQuestion),
          "securityAnswer": encrypt(securityAnswer),
          "id": encrypt(u),
          "aId": a
        },
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
        },
      ),
      );
      

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');

      if (result['msg'] != null) {
        print('The setup works');
        authResponse['isThereError'] = false;
        return authResponse;
      } else {
        authResponse['securityAnswerErr'] = defaultError;
        return authResponse;
      }
    } on DioException catch (e) {
      print('Error: ${e.response?.data}');

      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          authResponse['securityAnswerErr'] = 'Account does not exist';
          return authResponse;
        } else {
          authResponse['securityAnswerErr'] = defaultError;
          return authResponse;
        }
      } else {
        final errorMsg = e.response?.data;

          List <String> securityQuestionErrors = [];
          List <String> securityAnswerErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'securityQuestion') {
              securityQuestionErrors.add(error['msg']);
            } else {
              securityAnswerErrors.add(error['msg']);
            }
          }

          if (securityQuestionErrors != [] && securityAnswerErrors == []) {
              String securityQuestionErrorDisplay = securityQuestionErrors.join('\n');
              print('security Question Error: $securityQuestionErrorDisplay');
              authResponse['securityQuestionErr'] = securityQuestionErrorDisplay;
              authResponse['securityAnswerErr'] = '';
              return authResponse;
          } else if (securityQuestionErrors == [] && securityAnswerErrors != []) {
              String securityAnswerErrorDisplay = securityAnswerErrors.join('\n');
              print('security Answer Error: $securityAnswerErrorDisplay');
              authResponse['securityQuestionErr'] = '';
              authResponse['securityAnswerErr'] = securityAnswerErrorDisplay;
              return authResponse;
          } else {
              authResponse['securityQuestionErr'] = '';
              authResponse['securityAnswerErr'] = defaultError;
              return authResponse;
          }
      }
    }
}



Future<Map<String, dynamic>> getAccount ({required type}) async {
  Map<String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['type'] = type;

  final defaultError = "An Unknown Error Occured, Please try again";

  String j = getJ();
    String u = getU();

    u = encrypt(u);

    try {
      var res = await Dio().get(
        'http://192.168.31.190:8080/api/user/',
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
          'Identification': u
        },
      ),
      );
      

      String response = res.toString();
      print('Response prima: $response');
      final result = jsonDecode(response);

      if(authResponse['type'] == 'confirmSetup') {
            // print("From confrim setup check");
            // print(result['kycImage']);
            if (result['kycImage'] != null || result['kycImage'] != '') {
              setAS(true);
              return authResponse;
            } 
      }  else if(authResponse['type'] == 'getSecurityQuestion') {
            // print("from 'getSecurityQuestion'");
            if (result['accountSecurity'] != null || result['accountSecurity'] != '') {
              return result['accountSecurity'];
            }
      }  else {
            setAS(false);
            if (result['_id'] != null) {
            // print(result['firstName']);
            // print(result['lastName']);
            // print(result['mobile']);
            // print(result['address']);
            // print(result['_id']);
            // print(result['accountSecurity'][0]['securityQuestion']);
            // print(result['accountSecurity'][0]['securityAnswer']);
            print('The setup works');
            authResponse['isThereError'] = false;
            result['isThereError'] = authResponse['isThereError'];
            return result;
          } else {
            authResponse['error'] = defaultError;
            return authResponse;
          }
      }

        return authResponse;
    } on DioException catch (e) {
      print(e);
      print('Error: ${e.response?.data}');
      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          authResponse['error'] = 'Account does not exist';
          return authResponse;
        } else {
          authResponse['error'] = defaultError;
          return authResponse;
        }
      } else {
          authResponse['error'] = defaultError;
          return authResponse;
      }
    }
}



Future<Map<String, dynamic>> confirmAccountSecurityAuth ({required securityQuestion, required securityAnswer, required type}) async {
  Map <String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['securityAnswerErr'] = '';
  authResponse['securityQuestionErr'] = '';
  authResponse['type'] = type;
  securityQuestion = encrypt(securityQuestion);
  securityAnswer = encrypt(securityAnswer);


  String j = getJ();
    String u = getU();
    String a = getA();

    final defaultError = "An Unknown Error Occured, Please try again";

    // final String dePData =  decrypt(dotString);
    // print('Post encryption decrypted Password: ${dePData}');
    print('This is the user $u');
    // print('This is the json $j');

    try {
      var res = await Dio().post(
        'http://192.168.31.190:8080/api/user/confirmSecure',
        data: {
          "securityQuestion": encrypt(securityQuestion),
          "securityAnswer": encrypt(securityAnswer),
          "id": encrypt(u),
          "aId": a
        },
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
        },
      ),
      );
      

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);
      // print('Response: ${result['id']}');
      // print('Response: ${result['token']}');

      if (result['msg'] != null) {
        print('The setup works');
        authResponse['isThereError'] = false;
        return authResponse;
      } else {
        authResponse['securityAnswerErr'] = defaultError;
        return authResponse;
      }
    } on DioException catch (e) {
      print('Error: ${e.response?.data}');

      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          authResponse['securityAnswerErr'] = 'Account does not exist';
          return authResponse;
        } else {
          authResponse['securityAnswerErr'] = e.response?.data['error'];
          return authResponse;
        }
      } else {
        final errorMsg = e.response?.data;

          List <String> securityAnswerErrors = [];

          for (var error in errorMsg['errorMsg']) {
            if (error['path'] == 'securityAnswer') {
              securityAnswerErrors.add(error['msg']);
            }
          }

          if (securityAnswerErrors != []) {
              String securityAnswerErrorDisplay = securityAnswerErrors.join('\n');
              print('security Question Error: $securityAnswerErrorDisplay');
              authResponse['securityAnswerErr'] = securityAnswerErrorDisplay;
              return authResponse;
          } else {
              authResponse['securityAnswerErr'] = defaultError;
              return authResponse;
          }
      }
    }
}



Future<Map<String, dynamic>> kycUpload ({required type, required FormData formData}) async {
  Map<String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['type'] = type;

  final defaultError = "An Unknown Error Occured, Please try again";

  String j = getJ();
    String u = getU();
    String a = getA();

    print('This is the aId $a');

    u = encrypt(u);

    print("This is the formData");
    print(formData);

    try {
      var res = await Dio().post(
        'http://192.168.31.190:8080/api/user/uploadImage',
        data: formData,
        options: Options(
        headers: {
          'Authorization': 'Bearer $j',
          'Identification': u,
          'Verification': a
        },
      ),
      );
      

      String response = res.toString();
      print('Response: $response');
      final result = jsonDecode(response);

      if (result['msg'] == 'Success') {
        print('The suceess message ${result['msg']}');
        authResponse['isThereError'] = false;
        result['isThereError'] = authResponse['isThereError'];
        return result;
      } else {
        authResponse['error'] = defaultError;
        return authResponse;
      }
    } on DioException catch (e) {
      print(e);
      print('Error: ${e.response?.data}');
      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          authResponse['error'] = 'Account does not exist';
          return authResponse;
        } else {
          authResponse['error'] = defaultError;
          return authResponse;
        }
      } else {
          authResponse['error'] = defaultError;
          return authResponse;
      }
    }
}



Future<Map<String, dynamic>> getWallet ({required type}) async {
  Map<String, dynamic> authResponse = {};
  authResponse['isThereError'] = true;
  authResponse['type'] = type;

  final defaultError = "An Unknown Error Occured, Please try again";

  String j = getJ();
    String u = getU();

    u = encrypt(u);

    try {
      var res = await Dio().get(
        'http://192.168.31.190:8080/api/wallet/financials',
        options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $j',
          'Identification': u
        },
      ),
      );
      

      String response = res.toString();
      print('Response prima: $response');
      final result = jsonDecode(response);

      if (result['_id'] != null) {
        print('The setup works');
        authResponse['isThereError'] = false;
        result['isThereError'] = authResponse['isThereError'];
        return result;
      } else {
        authResponse['error'] = defaultError;
        return authResponse;
      }

    } on DioException catch (e) {
      print(e);
      print('Error: ${e.response?.data}');
      if (e.response?.data != null && e.response?.data['error'] != null) {
        print(e.response?.data['error']);
        if (e.response?.data['error'] == 'Request is not authorized') {
          authResponse['error'] = 'Account does not exist';
          return authResponse;
        } else {
          authResponse['error'] = defaultError;
          return authResponse;
        }
      } else {
          authResponse['error'] = defaultError;
          return authResponse;
      }
    }
}




