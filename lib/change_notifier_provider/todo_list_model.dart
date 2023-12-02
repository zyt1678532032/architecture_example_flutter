import 'package:flutter/cupertino.dart';

enum TodoStatus { pendingExecuted, partExecuted, computed }

class Todo {
  int id;
  String title;
  TodoStatus status;

  Todo({
    required this.id,
    required this.title,
    required this.status,
  });
}

class TodoListModel extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void loadingTodos() async {
    _todos = await _genMockTodos();
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    _todos = _todos.toList(); // 注意这里，因为使用Selector 需要 rebuilder，所以需要重新赋值，以更新widget
    notifyListeners();
  }


  Future<List<Todo>> _genMockTodos() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future(() => List.generate(20, (index) {
          return Todo(
            id: index,
            title: "title is num $index",
            status: TodoStatus.pendingExecuted,
          );
        }));
  }
}
