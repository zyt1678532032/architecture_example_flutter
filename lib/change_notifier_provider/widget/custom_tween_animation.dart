import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTweenAnimation extends StatefulWidget {
  const CustomTweenAnimation({
    required this.child,
    this.onlyScale = false,
    super.key,
    required this.onEnd,
  });

  final Widget child;
  final bool onlyScale;
  final Function onEnd;

  @override
  State<StatefulWidget> createState() => _CustomTweenAnimationState();
}

class _CustomTweenAnimationState extends State<CustomTweenAnimation> {
  double begin = 0;
  double end = -50 + 20;
  bool isFirstInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isFirstInit
            ? Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: TextField(),
                  ),
                  widget.child
                ],
              )
            : TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                tween: Tween(begin: begin, end: end),
                builder: (_, value, child) {
                  if (widget.onlyScale) {
                    return Transform.scale(
                      scale: lerpDouble(1, -1, value)?.clamp(0, 1),
                      child: child,
                    );
                  }
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                      child: TextField(),
                    ),
                    const SizedBox(
                      height: 50,
                      child: TextField(),
                    ),
                    widget.child
                  ],
                ),
              ),
        GestureDetector(
          onTap: () {
            isFirstInit = false;
            setState(() {
              if (begin == -50) {
                begin = 0;
                end = -50 + 20;
              } else {
                begin = -50;
                end = 20;
              }
            });
          },
          child: Container(
            color: Colors.orange,
            height: 20,
          ),
        ),
      ],
    );
  }
}
