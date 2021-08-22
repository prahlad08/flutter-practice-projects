import 'package:expense_planner/widgets/list.dart';

import '../transaction.dart';
import 'package:flutter/material.dart';
import './charts.dart';
import 'form.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

final titleController = TextEditingController();
final amountController = TextEditingController();

class _ExpenseTrackerState extends State<ExpenseTracker> {
  List<Transaction> transactions = [
    Transaction(title: "first", amount: 100, datetime: DateTime.now()),
    Transaction(title: "second", amount: 200, datetime: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Chart(),
        MyForm(
          titleController: titleController,
          amountController: amountController,
          onPressed:(){
            setState(() {
              transactions.add(Transaction(datetime: DateTime.now(),title:titleController.text,amount:double.parse(amountController.text)));
            });

          },
          list: transactions,
        ),
       ExpenseList(transactions: transactions,),
      ],
    );
  }
}
