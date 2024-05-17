import 'package:flutter/material.dart';

class StateLifecyclePage extends StatefulWidget {
  const StateLifecyclePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateLifecyclePageState();
}

class _StateLifecyclePageState extends State<StateLifecyclePage> {
  bool isChange = false;
  bool isRemove = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('State ===> StateLifecyclePage build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('StateLifecyclePage'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isChange = !isChange;
                    });
                  },
                  child: const Text('change widget'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRemove = !isRemove;
                    });
                  },
                  child: const Text('remove / insert'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('setState from ParenContext'),
                ),
              ],
            ),
          ),
          if (!isRemove) _isChangeWidget(),
        ],
      ),
    );
  }

  Widget _isChangeWidget() {
    return isChange
        ? StateWidget(
            key: ValueKey('StateWidgetOne'),
            title: 'StateWidgetOne',
            color: Colors.red,
          )
        : const StateWidget(
            key: ValueKey('StateWidgetTwo'),
            title: 'StateWidgetTwo',
            color: Colors.green,
          );
  }
}

class StateWidget extends StatefulWidget {
  final String title;
  final Color color;

  const StateWidget({super.key, required this.title, required this.color});

  @override
  State<StatefulWidget> createState() => _StateWidgetOne();
}

class _StateWidgetOne extends State<StateWidget> {
  @override
  void initState() {
    super.initState();
    debugPrint('State ===> StateWidget initState');
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('State ===> StateWidget deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('State ===> StateWidget dispose');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('State ===> StateWidget didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant StateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('State ===> StateWidget didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('State ===> StateWidget build');
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        color: widget.color,
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
