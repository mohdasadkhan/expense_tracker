import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitx/data/database_provider.dart';
import 'package:sqflitx/presentation/view/widgets/expense_chart.dart';
import 'package:sqflitx/presentation/view/widgets/expense_list.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = '/expense_screen';

  Future _getExpenseList(context, category) async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(category);
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$category Expense screen',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: FutureBuilder(
          future: _getExpenseList(context, category),
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
        ));
  }
}
