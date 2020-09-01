import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 509.0,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions added yet',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 230,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover, /*height: 230*/
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 3.5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(2.5),
                          child: FittedBox(
                              child: Text(
                            '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        )),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                    title: Text(transactions[index].title,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
              //children: transactions.map((tx) {}).toList(),
            ),
    );
  }
}
