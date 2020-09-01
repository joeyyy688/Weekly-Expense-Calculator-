import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void extractDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2020, 1, 1),
            initialDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  /*border: OutlineInputBorder(),*/ labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  /*border: OutlineInputBorder(),*/ labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(selectedDate == null
                      ? 'No Date Chosen'
                      : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                ),
                FlatButton(
                    child: Text(
                      'Choose Date!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).textTheme.button.color,
                    onPressed: extractDatePicker),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              splashColor: Colors.purple,
              child: Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
