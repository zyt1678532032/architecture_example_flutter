import 'dart:ffi';

import 'package:architecture_example_flutter/change_notifier_provider/widget/custom_tween_animation.dart';
import 'package:architecture_example_flutter/change_notifier_provider/widget/todos_page.dart';
import 'package:flutter/material.dart';
import 'model/todo_list_model.dart';

/// Provider + ChangeNotifier 业务结构
class HomePageForProvider extends StatefulWidget {
  const HomePageForProvider({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _HomePageForProvider();
  }
}

class _HomePageForProvider extends State<HomePageForProvider> {
  final _tab = ValueNotifier<TodoStatus>(TodoStatus.all);

  bool isChangeTextStyle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: ValueListenableBuilder<TodoStatus>(
        valueListenable: _tab,
        builder: (context, todoStatus, child) {
          return Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: TodoStatus.values.indexOf(todoStatus),
              onTap: (index) => _tab.value = TodoStatus.values[index],
              unselectedFontSize: 14,
              useLegacyColorScheme: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: "全部",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm),
                  label: "已完成",
                )
              ],
            ),
          );
        },
      ),
      body: ValueListenableBuilder<TodoStatus>(
        valueListenable: _tab,
        builder: (context, todoStatus, child) {
          return Column(
            children: [
              AnimatedDefaultTextStyle(
                style: isChangeTextStyle
                    ? const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      )
                    : const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                child: const Text('AnimatedDefaultTextStyle'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isChangeTextStyle = !isChangeTextStyle;
                  });
                },
                child: const Text('改变TextStyle'),
              ),
              CustomTweenAnimation(
                onlyScale: false,
                onEnd: (child) {
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: child,
                  );
                },
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 1, end: 0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.scale(
                      scaleY: value,
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.green,
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
