import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/todo_list_model.dart';

class AllTodosPage extends StatefulWidget {
  const AllTodosPage({super.key});

  @override
  State<StatefulWidget> createState() => _AllTodosPageState();
}

class _AllTodosPageState extends State<AllTodosPage>
    with TickerProviderStateMixin {
  var isShow = ValueNotifier(false);

  var tabIndex = ValueNotifier(0);

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
      selector: (context, model) => model.allTodos,
      shouldRebuild: (pre, next) => pre != next,
      builder: (context, todos, child) {
        print('Selector builder');
        return ListView.builder(
          key: const Key('__todoList__'),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(todos[index]),
              background: Container(color: Colors.green),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: ListTile(
                          title: Text(todos[index].title),
                          subtitle: Text(todos[index].status.toString()),
                          onTap: () => isShow.value = true,
                        ),
                      ),
                      TextButton(
                        onPressed: () => isShow.value = false,
                        child: const Text('button'),
                      )
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: tabIndex,
                    builder: (context, index, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => tabIndex.value = 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => tabIndex.value = 1,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.green,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => tabIndex.value = 2,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => tabIndex.value = 3,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: tabIndex,
                    builder: (context, index, child) {
                      return AnimatedContainer(
                        width: MediaQuery.of(context).size.width - 20,
                        height: index == 0 || index == 2 ? 40.0 : 80.0,
                        color:
                            index == 0 || index == 2 ? Colors.red : Colors.blue,
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        child: const FlutterLogo(size: 75),
                      );
                    },
                  ),
                  // RectAnimationWidget(
                  //   listenable: isShow,
                  // ),
                ],
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

class RectAnimationWidget extends AnimatedWidget {
  const RectAnimationWidget({super.key, required super.listenable});

  ValueNotifier<bool> get isShow => listenable as ValueNotifier<bool>;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(
        width: 100,
        height: 100,
        color: Colors.black,
      ),
      secondChild: Container(
        width: 100,
        height: 200,
        color: Colors.blue,
      ),
      crossFadeState:
          isShow.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 400),
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
