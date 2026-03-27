import 'package:flutter/material.dart';
import 'package:todo/config/theme.dart';
import 'package:todo/data/local/app_db.dart';
import 'package:todo/view/todos_view.dart';
import 'package:provider/provider.dart';

void main() {
  final db = AppDatabase();
  
  runApp(
    Provider(
      create: (context) => db,
      dispose: (context, db) => db.close(),
      child: const MyApp() 
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: appTheme,
      home: const TodosView(),
    );
  }
}