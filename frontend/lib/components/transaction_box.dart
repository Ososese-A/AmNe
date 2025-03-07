import 'package:flutter/material.dart';
import 'package:frontend/add_ons/transaction_record.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionBox extends StatefulWidget {
  const TransactionBox({super.key});

  @override
  State<TransactionBox> createState() => _TransactionBoxState();
}

Map<String, List<Map>> groupRecordsByDate(List<Map> records) {
  Map<String, List<Map>> groupedRecords = {};

  records.forEach((record) {
    String date = DateFormat('dd MMM yyyy').format(
      DateTime.fromMillisecondsSinceEpoch(record['dateTime'])
    );
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
    final List<dynamic> transactionHistory = Provider.of<HistoryModel>(context).transactionHistory;

    List<Map<dynamic, dynamic>> typedTransactionHistory = transactionHistory.map((item) => item as Map<dynamic, dynamic>).toList();

    DateTime now = DateTime.now();
    String todaysDate = DateFormat('dd MMM yyyy').format(now);
    String yesterdaysDate = DateFormat('dd MMM yyyy').format(
      DateTime.now().subtract(Duration(days: 1))
    );

    Map<String, List<Map>> groupedRecords = groupRecordsByDate(typedTransactionHistory);
    List<String> dates = groupedRecords.keys.toList();
  
    return Expanded(
      child: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          String date = dates[index];
          List<Map> itemsForDate = groupedRecords[date]!;
          print('This is the date value $date');
          print("today's date check ${date == todaysDate} $date");
          print("yesterday's date check ${date == yesterdaysDate} $yesterdaysDate");

          return Column(
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
                      'transactionId': item['_id'],
                      'participant': item['participant'],
                      'participantType': double.parse(item['amount'].toString()) > 0,
                      'transactionType': item['type'],
                      'transactionFee': item['fee'].toString(),
                      'currency': "ETN",
                      'amount': item['amount'].toString(),
                      'date': date,
                      'time': DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(item['dateTime'])
                      ),
                    }),
                    child: transaction_record(
                      "ETN",
                      item['amount'].toString(),
                      item['participant'],
                      DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(item['dateTime'])
                      ),
                      item["transactionType"]
                    )
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