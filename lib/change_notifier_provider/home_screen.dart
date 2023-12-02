import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/todo_list_model.dart';

/// Provider + ChangeNotifier 业务结构
class HomePageForProvider extends StatelessWidget {
  const HomePageForProvider({super.key, required this.title});

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
