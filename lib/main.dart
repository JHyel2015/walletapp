import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/data/expense_data.dart';
import 'package:walletapp/pages/home_page.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        // theme: ThemeData().copyWith(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/homepage': (context) => const HomePage(),
        },
      ),
    );
  }
}
