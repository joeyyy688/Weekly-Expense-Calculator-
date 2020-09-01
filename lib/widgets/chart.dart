import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var transactionSum = 0.00;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day && recentTransactions[i].date.month == weekday.month && recentTransactions[i].date.year == weekday.year) {
          transactionSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': transactionSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues);
    return Container(
      child: Card(
        // color: Colors.blue,
        // child: Text('CHART!'),
        elevation: 6,
        margin: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                data['amount'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
