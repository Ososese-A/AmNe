import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/components/kyc_upload_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:mime/mime.dart';

class KycUploadPage extends StatefulWidget {
  const KycUploadPage({super.key});

  @override
  State<KycUploadPage> createState() => _KycUploadPageState();
}

class _KycUploadPageState extends State<KycUploadPage> {
  String? _filePath;
  int? _fileSize;
  bool isUploaded = false;
  String uploadError  = "";
  bool allDoneWithNoIssues = false;

  Future<void> _pickFile() async {
    print("tapped");
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileSize = result.files.single.size;
        print(_filePath);
        print(result);
      });
      _checkFileSize();
    }
  }

  void _checkFileSize() {
    if (_fileSize != null) {
      // Convert bytes to megabytes
      final fileSizeInMB = _fileSize! / (1024 * 1024); 
      if (fileSizeInMB > 5) {
        print('File is larger than 5 MB');
        setState(() {
          uploadError = "File is larger than 5 MB";
        });
      } else {
        print('File is within the limit of 5 MB');
        //upload to db
        _uploadFile();

        setState(() {
          isUploaded = true;
        });
      }
    }
  }

  Future<void> _uploadFile() async {
    if (_filePath != null) {
      String fileName = _filePath!.split('/').last;
      String mimeType = lookupMimeType(_filePath!) ?? 'application/octet-stream';

      RegExp imageMimeType = RegExp(r'image/(jpeg|jpg|png)');
      // RegExp imageMimeType = RegExp(r'image/(png)');
      if (imageMimeType.hasMatch(mimeType)) {
        print("Recognized");
        print(mimeType);

        FormData formData = FormData.fromMap({
          "kycImage": await MultipartFile.fromFile(
            _filePath!,
            filename: fileName,
            // Manually set MIME type to resolve backend problem with multer
            contentType: DioMediaType.parse(mimeType), 
          ),
        });

        final uploadStatus = await kycUpload(type: 'upload', formData: formData);

        if (uploadStatus['isThereError']) {
          setState(() {
            uploadError = uploadStatus['error'];
          });
        } else {
            setState(() {
              uploadError = '';
            allDoneWithNoIssues = true;
          });

          await getAccount(type: 'confirmSetup');
        }

      } else {
        setState(() {
          uploadError = 'Error: Only image files are allowed!';
        });
        // print(uploadError);
      }
    }
  }


  void showError () {
    setState(() {
      uploadError = 'Please upload a valid Image';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Account Setup"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),

            GestureDetector(
              onTap: _pickFile,
              child: Container(
                child: KycUploadField(upload: isUploaded),
              ),
            ),

            SizedBox(height: 8.0,),

            Container(
            width: double.infinity,
            height: 80.0,
            child: Text(
              uploadError,
              // "Error",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: customColors.app_red,
                fontSize: 14.0
              ),
            ),
          ),

            SizedBox(height: 40.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btn("Done", false, () {
                  if  (allDoneWithNoIssues) {
                      pop_up(
                      ctx: context,
                      txt: 'Your account has been setup successfully',
                      minor: false,
                      primaryBtn: true,
                      primaryBtnTxt: 'Done',
                      primaryBtnOnTap: () => setMainPage(context, '/main', '/main')
                    );
                  } else {
                    showError();
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}