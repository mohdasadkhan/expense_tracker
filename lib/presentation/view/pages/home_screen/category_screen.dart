import 'package:flutter/material.dart';
import 'category_fetcher.dart';
import '../add_expenses/expense_form.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ExpenseForm(),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
