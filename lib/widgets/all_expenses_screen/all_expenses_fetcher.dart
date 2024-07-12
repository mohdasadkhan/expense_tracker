import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/database_provider.dart';
import './all_expenses_list.dart';

class AllExpensesFetcher extends StatelessWidget {
  const AllExpensesFetcher({super.key});

  Future _getAllExpenses(context) async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAllExpenses(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const Expanded(child: AllExpensesList());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
