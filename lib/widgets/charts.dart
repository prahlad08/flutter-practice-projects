import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final list;

  Chart({this.list});

  List<Transaction> get weekly {
    return list.where((ele) {
      return ((ele.datetime.difference(DateTime.now())).inDays <= 7)
          ? true
          : false;
    }).toList();
  }

  List week = [];
  double tot = 0.0;

  void func() {
    var sum = 0.0;

    for (int i = 0; i < 7; i++) {
      sum = 0;
      for (int j = 0; j < weekly.length; j++) {
        if (DateTime.now().difference(weekly[j].datetime).inDays == i) {
          sum += weekly[j].amount;
        }
      }
      week.add({
        'weekday': DateFormat.EEEE()
            .format(DateTime.now().subtract(Duration(days: i)))[0],
        'amount': sum.toString(),
      });
      print(week[i]['weekday']);
      tot += sum;
    }
    print(tot);
  }

  @override
  Widget build(BuildContext context) {
    list.length > 0 ? func() : () {};
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        padding: EdgeInsets.all( constraints.maxHeight*0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        child: Center(
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: week
                  .map((e) => Container(
                       // height: constraints.maxHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                height: constraints.maxHeight * 0.10,
                                child: Text('${e["weekday"]}'),
                                margin: EdgeInsets.only(bottom: constraints.maxHeight*0.01),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.5,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blueGrey),
                                ),
                                Container(
                                  height: tot == 0
                                      ? 0
                                      : double.parse(e['amount']) /
                                          tot *
                                          constraints.maxHeight *
                                          0.5,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          Theme.of(context).primaryColorDark),
                                )
                              ],
                            ),
                            FittedBox(
                              child: Container(
                                height: constraints.maxHeight * 0.10,
                                child: Text(
                                  '\$${e['amount']}',
                                  style: TextStyle(),
                                ),
                                margin: EdgeInsets.only(top:  constraints.maxHeight*0.01),
                              ),
                            )
                          ],
                        ),
                      ),
              )
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}
