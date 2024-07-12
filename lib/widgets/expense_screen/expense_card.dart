import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';
import '../../constants/icons.dart';
import './confirm_box.dart';

class ExpenseCard extends StatelessWidget {
  final Expense exp;
  const ExpenseCard(this.exp, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Dismissible(
        key: ValueKey(exp.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (_) async {
          return showDialog(
            context: context,
            builder: (_) => ConfirmBox(exp: exp),
          );
        },
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            child: Icon(icons[exp.category], color: Colors.white),
          ),
          title: Text(
            exp.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            '${DateFormat('EEEE').format(exp.date)}, ${DateFormat('MMMM dd, yyyy').format(exp.date)}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Text(
            NumberFormat.currency(locale: 'en_IN', symbol: '₹')
                .format(exp.amount),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
