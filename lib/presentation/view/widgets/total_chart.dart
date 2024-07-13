import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflitx/data/database_provider.dart';

class TotalChart extends StatelessWidget {
  const TotalChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.categories;
        var total = db.calculateTotalExpenses();

        return Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total Expenses:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    NumberFormat.currency(locale: 'en_IN', symbol: '₹')
                        .format(total),
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: list.map((e) {
                      double percentage =
                          total != 0 ? (e.totalAmount / total) * 100 : 0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          children: [
                            Container(
                              width: 12.0,
                              height: 12.0,
                              color: Colors.primaries[list.indexOf(e)],
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(' ${e.title}'),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '${percentage.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    // color: Colors.yellow,
                    height: 150,
                    width: 150,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 20.0,
                        sections: total != 0
                            ? list
                                .asMap()
                                .entries
                                .map(
                                  (entry) => PieChartSectionData(
                                      value: entry.value.totalAmount.toDouble(),
                                      color: Colors.primaries[entry.key],
                                      titleStyle: const TextStyle(fontSize: 0)),
                                )
                                .toList()
                            : [
                                PieChartSectionData(
                                  color: Colors.transparent,
                                  value: 1,
                                  title: 'No expenses',
                                  radius: 20.0,
                                  titleStyle: const TextStyle(
                                    fontSize: 0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
