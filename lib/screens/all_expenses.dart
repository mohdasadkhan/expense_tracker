import 'package:flutter/material.dart';
import 'package:sqflitx/widgets/all_expenses_screen/expense_search.dart';
import '../widgets/all_expenses_screen/all_expenses_fetcher.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});
  static const name = '/all_expenses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Expenses')),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpenseSearch(),
          ),
          AllExpensesFetcher(),
        ],
      ),
    );
  }
}
