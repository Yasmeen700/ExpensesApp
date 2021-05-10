import 'package:intl/intl.dart';
import '../widget/chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {


    return List.generate(7, (index) {

        final weekDay = DateTime.now().subtract(
          Duration(days: index+3),
        );


      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, element) => sum += element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      e['day'],
                      totalSpending == 0.0
                          ? 0.0
                          : (e['amount'] as double) / totalSpending,
                      e['amount']),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

