import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double percentageOfBar;
  final double totalSpendingAmount;

  ChartBar(this.label, this.percentageOfBar, this.totalSpendingAmount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        SizedBox(height: 8),
        Container(
          height: 18,
          child: FittedBox(
            child: Text('\$${totalSpendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
                child: FractionallySizedBox(
                  heightFactor: percentageOfBar,
                  child: Container(
                    //color: Theme.of(context).primaryColor,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(label),
        SizedBox(height: 8),
      ]),
    );
  }
}
