import 'package:flutter/cupertino.dart';

import './widgets/ExpenseStartScreen.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/widgets/list.dart';

import './transaction.dart';
import 'package:flutter/material.dart';
import './widgets/charts.dart';
import './widgets/form.dart';

void main() {
  runApp(MyApp());
}
const url2='https://cdn.pixabay.com/photo/2020/06/11/01/41/sleep-5284831_960_720.png';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Transaction> transactions = [
    Transaction(title: "first", amount: 100, datetime: DateTime.now()),
    Transaction(title: "second", amount: 200, datetime: DateTime.now())
  ];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
void addTransaction(DateTime dt){
  setState(() {
    transactions.add(Transaction(datetime: dt,
        title: titleController.text,
        amount: double.parse(amountController.text)));
  });

}
  void showTheBottom(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, isScrollControlled: true, builder: (bctx) {
      return GestureDetector(
        onTap: () {},
        child: MyForm(
          titleController: titleController,
          amountController: amountController,
          onPressed: addTransaction,
          list: transactions,
        ),
      );
    });
  }
  final appBar=AppBar(
    title: Text("Expense Planner"),
    actions: [
      Builder(builder: (context) =>
          IconButton(icon: Icon(Icons.add), onPressed: () {
            showTheBottom(context)=>0;
          }))
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.purple,
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  )
              )
          ),
          textTheme: TextTheme(

              bodyText2: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontSize: 14
              )
          )
      ),
      home: Builder(
        builder: (context){
          return Scaffold(
            appBar: appBar,
            body: Column(
              children: [
                transactions.length>0?Container(height:(MediaQuery.of(context).size.height -appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.33,child: Chart(list:transactions)):SizedBox(width:1,height: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('All transactions', style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ), textAlign: TextAlign.left,),
                ),
                transactions.length == 0 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,
                        child:Text("No transactions recorded recently")),
                    Image(image: NetworkImage(url2),fit: BoxFit.cover,)
                  ],

                )

                    : Container(
                  height: (MediaQuery.of(context).size.height -appBar.preferredSize.height-MediaQuery.of(context).padding.along(Axis.vertical))*0.6,
                  child: ExpenseList(transactions: transactions, onPressed: (index) {
                    setState(() {
                      transactions.removeAt(index);
                    });
                  },),
                ),
              ],
            ),
            floatingActionButton: Builder(builder: (context) =>
                FloatingActionButton(child: Icon(Icons.add), onPressed: () {
                  showTheBottom(context);
                },)),
          );
        },
      ),
    );
  }
}
