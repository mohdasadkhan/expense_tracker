import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/database_provider.dart';
// screens
import './screens/category_screen.dart';
import './screens/expense_screen.dart';
import './screens/all_expenses.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: 'expense_tracker_group_key',
      channelKey: 'expense_tracker_key',
      channelName: 'expense_tracker',
      channelDescription: 'expense_tracker_local_notifications',
    ),
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'expense_tracker_channel_group_key',
        channelGroupName: 'expense_tracker_group_name')
  ]);
  bool isAllowedNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
    );
  }
}
