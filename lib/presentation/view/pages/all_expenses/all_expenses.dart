import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitx/data/database_provider.dart';
import 'package:sqflitx/presentation/view/pages/all_expenses/all_expenses_list.dart';
import 'package:sqflitx/presentation/view/widgets/expense_search.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});
  static const name = '/all_expenses';

  Future _getAllExpenses(context) async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool _) {
        Provider.of<DatabaseProvider>(context, listen: false).searchText = '';
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('All Expenses')),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ExpenseSearch(),
            ),
            FutureBuilder(
              future: _getAllExpenses(context),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Expanded(child: AllExpensesList());
                } else {
                  return const Text("Loading..");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
