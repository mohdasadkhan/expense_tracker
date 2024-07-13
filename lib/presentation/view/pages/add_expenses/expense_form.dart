import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sqflitx/controllers/notification_controller.dart';
import 'package:sqflitx/data/database_provider.dart';
import '../../../../constants/icons.dart';
import '../../../../domain/models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _date = TextEditingController();
  String _initialValue = 'Other';
  final _dateFocusNode = _DisabledFocusNode();
  late FocusNode _titleFocusNode;
  late FocusNode _amountFocusNode;
  DateTime? _selectedDate;

  Future<void> _showDatePicker(final BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      _selectedDate = selectedDate;
      _date.text = DateFormat('MMMM dd, yyyy').format(selectedDate);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _date.dispose();
    _dateFocusNode.unfocus();
    _titleFocusNode.unfocus();
    _amountFocusNode.unfocus();

    super.dispose();
  }

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    _titleFocusNode = FocusNode();
    _amountFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                focusNode: _titleFocusNode,
                controller: _title,
                decoration: InputDecoration(
                  icon: const Icon(Icons.edit),
                  labelText: 'Title of expense',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_amountFocusNode);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                focusNode: _amountFocusNode,
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: const Icon(Icons.view_headline),
                  labelText: 'Amount of expense',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                focusNode: _dateFocusNode,
                controller: _date,
                onTap: () => _showDatePicker(context),
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today_rounded),
                  labelText: 'DueDate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Icon(
                    Icons.category_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: icons.keys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      value: _initialValue,
                      onChanged: (newValue) {
                        setState(() {
                          _initialValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_title.text.isNotEmpty &&
              _amount.text.isNotEmpty &&
              _selectedDate != null) {
            final file = Expense(
              id: 0,
              title: _title.text,
              amount: double.parse(_amount.text),
              date: _selectedDate!,
              category: _initialValue,
            );
            Provider.of<DatabaseProvider>(context, listen: false).addExpense(file);
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 1,
                channelKey: 'expense_tracker_key',
                title: '$_initialValue Expense Added',
                body:
                    '${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(int.parse(_amount.text))} added in your $_initialValue Entries',
              ),
            );
            Navigator.of(context).pop();
          }
        },
        backgroundColor: Theme.of(context).primaryColorLight,
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const Center(
            child: Text(
              'Add Expense',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class _DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
