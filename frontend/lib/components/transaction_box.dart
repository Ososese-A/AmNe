import 'package:flutter/material.dart';
import 'package:frontend/add_ons/transaction_record.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:intl/intl.dart';

class TransactionBox extends StatefulWidget {
  const TransactionBox({super.key});

  @override
  State<TransactionBox> createState() => _TransactionBoxState();
}

Map<String, List<Map>> groupRecordsByDate(List<Map> records) {
  Map<String, List<Map>> groupedRecords = {};

  records.forEach((record) {
    String date = record['date'];
    if (!groupedRecords.containsKey(date)) {
      groupedRecords[date] = [];
    }
    groupedRecords[date]!.add(record);
  });

  return groupedRecords;
}

class _TransactionBoxState extends State<TransactionBox> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String todaysDate = DateFormat('dd MMM yyyy').format(now);
    String yesterdaysDate = DateFormat('dd MMM yyyy').format(DateTime.now().subtract(Duration(days: 1)));

    List <Map> recordUnderDate = [{
      'currency': 'ETN',
      'amount': '-10.00',
      'participant': '0xDfc57Bd719e6378901296BFa21BEaaB9478997b5',
      'date': DateFormat('dd MMM yyy').format(DateTime.parse('2025-02-27 09:53:36.081866')),
      'time': DateFormat('hh:mm a').format(DateTime.parse('2025-02-27 09:53:36.081866')),
    },{
      'currency': 'NGN',
      'amount': '10000.00',
      'participant': 'Hajara Asiwaju',
      'date': DateFormat('dd MMM yyy').format(DateTime.parse('2025-02-26 12:33:36.081866')),
      'time': DateFormat('hh:mm a').format(DateTime.parse('2025-02-26 12:33:36.081866')),
    },{
      'currency': 'NGN',
      'amount': '-100000.00',
      'participant': 'Benjmin Musa',
      'date': DateFormat('dd MMM yyy').format(DateTime.parse('2025-02-26 12:33:36.081866')),
      'time': DateFormat('hh:mm a').format(DateTime.parse('2025-02-26 12:33:36.081866')),
    },{
      'currency': 'ETN',
      'amount': '67.00',
      'participant': '0x0Da5F9f0239908385C1748ECbB473C5763401cb9',
      'date': DateFormat('dd MMM yyy').format(DateTime.parse('2024-07-25 19:50:36.081866')),
      'time': DateFormat('hh:mm a').format(DateTime.parse('2024-07-25 19:50:36.081866')),
    }];

    Map<String, List<Map>> groupedRecords = groupRecordsByDate(recordUnderDate);
    List<String> dates = groupedRecords.keys.toList();
  
  // Print the grouped records
  // groupedRecords.forEach((date, records) {
  //   print('Date: $date');
  //   records.forEach((record) {
  //     print('  ${record['currency']} - ${record['amount']} - ${record['participant']}');
  //   });
  // });

    return Expanded(
            child: ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) {
                String date = dates[index];
                List<Map> itemsForDate = groupedRecords[date]!;
                print('This is the date value $date');
                print("today's date check ${date == todaysDate} $date");
                print("yesterday's date check ${date == yesterdaysDate} $yesterdaysDate");

                return
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date == todaysDate
                      ? "Today"
                      : date == yesterdaysDate
                          ? "Yesterday"
                          : date,
                      style: TextStyle(color: customColors.app_white, fontSize: 16.0)
                    ),
                    SizedBox(height: 12.0,),
                    Column(
                      children: itemsForDate.map((item) {
                        return GestureDetector(
                          onTap: () => nextWithData(context, '/viewTransaction', {
                            'transactionId': 'z9ZHBahg7qKXxgthu8eP3ABP7k3ra5WH',
                            //for stock purchases the participant is you (the user)
                            'participant': item['participant'],
                            'participantType': double.parse(item['amount']) > 0,
                            'transactionType': 'Withdrawal',
                            // 'transactionFee': item['fee'],
                            // 'transactionType': item['type'],
                            'transactionFee': '5.00',
                            'currency': item['currency'],
                            'amount': item['amount'],
                            'date': date,
                            'time': item['time'],
                          }),
                          child: transaction_record(item['currency'], item['amount'], item['participant'], item['time'])
                        );
                      }).toList(),
                    )
                  ],
                );
              }
            )
          );
  }
}