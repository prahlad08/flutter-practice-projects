import 'package:flutter/foundation.dart';

class Transaction{
  String title;
  String description;
  double amount;
  DateTime datetime;
  Transaction({this.datetime,this.amount,this.description,this.title});
}