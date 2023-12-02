import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier_provider/todo_list_model.dart';

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
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Selector<TodoListModel, List<Todo>>(
        selector: (context, model) => model.todos,
        shouldRebuild: (pre, next) => pre != next,
        builder: (context, todos, child) {
          print('Selector builder');
          return ListView.builder(
            key: const Key('__todoList__'),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(todos[index]),
                background: Container(color: Colors.green),
                child: ListTile(
                  title: Text(todos[index].title),
                  subtitle: Text(todos[index].status.toString()),
                ),
                onDismissed: (_) {
                  context.read<TodoListModel>().deleteTodo(todos[index].id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
