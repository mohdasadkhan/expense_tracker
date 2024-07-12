import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/ex_category.dart';
import '../../screens/expense_screen.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ExpenseScreen.name,
          arguments: category.title,
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColorLight,
        child: Icon(category.icon, color: Colors.white),
      ),
      title: Text(
        category.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
        'entries: ${category.entries}',
        style: TextStyle(color: Colors.grey[600]),
      ),
      trailing: Text(
        NumberFormat.currency(locale: 'en_IN', symbol: '₹')
            .format(category.totalAmount),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: Colors.green,
        ),
      ),
    );
  }
}
