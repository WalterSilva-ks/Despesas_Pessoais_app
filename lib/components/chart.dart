// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transation.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentsTransaction;

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentsTransaction.length; i++) {
        bool sameDay = recentsTransaction[i].date.day == weekday.day;
        bool sameMonth = recentsTransaction[i].date.month == weekday.month;
        bool sameYear = recentsTransaction[i].date.year == weekday.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentsTransaction[i].value;
        }
      }

      DateFormat.E().format(weekday)[0];
      return {'day': DateFormat.E().format(weekday)[0], 'value': totalSum};
    }).reversed.toList();
  }

  const Chart(this.recentsTransaction);

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'].toString(),
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (tr['value'] as double) / _weekTotalValue,
                  value: double.parse(tr['value'].toString()),
                ),
              );
            }).toList(),
          ),
        ));
  }
}
