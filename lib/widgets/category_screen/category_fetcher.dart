import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/database_provider.dart';
import './total_chart.dart';
import './category_list.dart';
import '../../screens/all_expenses.dart';

class CategoryFetcher extends StatelessWidget {
  const CategoryFetcher({super.key});

  Future _getCategoryList(context) async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCategoryList(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                            .copyWith(right: 40),
                    child: const TotalChart(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Expenses',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AllExpenses.name);
                                },
                                child: const Text('View All'),
                              ),
                            ],
                          ),
                        ),
                        const CategoryList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
