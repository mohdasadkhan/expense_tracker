import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/database_provider.dart';
import './expense_list.dart';
import './expense_chart.dart';

class ExpenseFetcher extends StatelessWidget {
  final String category;

  const ExpenseFetcher({super.key, required this.category});

  Future _getExpenseList(context) async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getExpenseList(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ExpenseChart(category),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ExpenseList(),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
