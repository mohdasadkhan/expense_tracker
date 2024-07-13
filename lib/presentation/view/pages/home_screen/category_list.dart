import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitx/data/database_provider.dart';
import 'package:sqflitx/presentation/view/pages/view_expenses_screen/expense_screen.dart';
import '../../widgets/category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.categories;
        return Column(
          children: List.generate(
              list.length,
              (i) => CategoryCard(
                    list[i],
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ExpenseScreen.name,
                        arguments: list[i].title,
                        
                      );
                    },
                  )),
        );
      },
    );
  }
}
