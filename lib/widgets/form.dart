import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction.dart';

class MyForm extends StatefulWidget {
  final titleController;
  final amountController;
  final list;
  final onPressed;
  static final fk = GlobalKey<FormState>();
  DateTime date;
  MyForm(
      {this.onPressed, this.list, this.titleController, this.amountController});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  Future datetime;
  void showdatepicker() {
    datetime=showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days:30)),
        lastDate: DateTime.now().add(Duration(days:30))).then((value){
      if(value!=null){
          setState(() {
        widget.date=value;

      });}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        padding: EdgeInsets.all(10),
        child: Form(
          key: MyForm.fk,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: widget.titleController,
                  validator: (val) {
                    if (val.length < 4) return "Please Enter a valid title";
                    if (val.length > 10) return "Too huge ";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: widget.amountController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (double.parse(val) <= 0)
                      return "Please Enter a valid amount";
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text(widget.date!=null?"Date selected : ${DateFormat.yMd().format(widget.date)}":"No date chosen")),
                  FlatButton(
                    child: Text("Choose a date "),
                    onPressed: () {
                      showdatepicker();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: OutlineButton(
                  child: Text("Submit"),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    if (!MyForm.fk.currentState.validate() || widget.date==null) return;
                    print(widget.date);
                    widget.onPressed(widget.date);
                    MyForm.fk.currentState.reset();
                    widget.titleController.clear();
                    widget.amountController.clear();
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
