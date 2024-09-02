import 'package:expense_tracker_app/bar%20graph/bar_graph.dart';
import 'package:expense_tracker_app/data/expanse_data.dart';
import 'package:expense_tracker_app/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummery extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummery({super.key, required this.startOfWeek});

  // calculate max amount in bar graph
  double calculateMax(
      ExpanseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpanseSummery()[sunday] ?? 0,
      value.calculateDailyExpanseSummery()[monday] ?? 0,
      value.calculateDailyExpanseSummery()[tuesday] ?? 0,
      value.calculateDailyExpanseSummery()[wednesday] ?? 0,
      value.calculateDailyExpanseSummery()[thursday] ?? 0,
      value.calculateDailyExpanseSummery()[friday] ?? 0,
      value.calculateDailyExpanseSummery()[saturday] ?? 0,
    ];
    // sort to smallest to largest
    values.sort();
    // sort largest to smallest
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  // calculate weak total
  String calculateWeakTotal(
      ExpanseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    List<double> values = [
      value.calculateDailyExpanseSummery()[sunday] ?? 0,
      value.calculateDailyExpanseSummery()[monday] ?? 0,
      value.calculateDailyExpanseSummery()[tuesday] ?? 0,
      value.calculateDailyExpanseSummery()[wednesday] ?? 0,
      value.calculateDailyExpanseSummery()[thursday] ?? 0,
      value.calculateDailyExpanseSummery()[friday] ?? 0,
      value.calculateDailyExpanseSummery()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of the weak
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpanseData>(builder: (context, value, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Weak total'),
                Text('RS : ${calculateWeakTotal(
                  value,
                  sunday,
                  monday,
                  tuesday,
                  wednesday,
                  thursday,
                  friday,
                  saturday,
                )}')
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(
                value,
                sunday,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
              ),
              sunAmount: value.calculateDailyExpanseSummery()[sunday] ?? 0,
              monAmount: value.calculateDailyExpanseSummery()[monday] ?? 0,
              tueAmount: value.calculateDailyExpanseSummery()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpanseSummery()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpanseSummery()[thursday] ?? 0,
              friAmount: value.calculateDailyExpanseSummery()[friday] ?? 0,
              satAmount: value.calculateDailyExpanseSummery()[saturday] ?? 0,
            ),
          ),
        ],
      );
    });
  }
}
