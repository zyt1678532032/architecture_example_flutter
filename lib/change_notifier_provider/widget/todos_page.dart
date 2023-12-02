import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_list_model.dart';

class AllTodosPage extends StatelessWidget {
  const AllTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
      selector: (context, model) => model.allTodos,
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
    );
  }
}

class ComputedTodosPage extends StatelessWidget {
  const ComputedTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
      selector: (context, model) => model.computedTodos,
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
    );
  }
}
