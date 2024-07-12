import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/database_provider.dart';
import '../../models/expense.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    super.key,
    required this.exp,
  });

  final Expense exp;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: Text(
        'Delete ${exp.title}?',
        style: const TextStyle(fontSize: 20),
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text('Are you sure you want to delete this?'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Don\'t delete'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            provider.deleteExpense(exp.id, exp.category, exp.amount);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
