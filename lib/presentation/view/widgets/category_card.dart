import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflitx/domain/models/ex_category.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  final VoidCallback onTap;
  const CategoryCard(this.category, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
