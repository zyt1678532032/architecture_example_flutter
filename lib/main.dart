import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier_provider/home_screen.dart';
import 'change_notifier_provider/model/todo_list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListModel()..loadingTodos(),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePageForProvider(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
