import 'package:expense_planner/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ExpenseList extends StatelessWidget {
  final List <Transaction>transactions;
  final onPressed;
  ExpenseList({this.onPressed,this.transactions});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        //height:
        //400,
        child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                          child: Text('\$${transactions[i].amount}')),
                    ),
                    title: Text('${transactions[i].title}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('${DateFormat.yMMM().format(transactions[i].datetime)}', style:
                    TextStyle(fontSize: 14, color: Colors.grey)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever, color: Theme
                          .of(context)
                          .errorColor, size: 30,), onPressed:(){
                        onPressed(i);
                    },),
                  ),
                ),
              );
            }),
      );
  }
}
