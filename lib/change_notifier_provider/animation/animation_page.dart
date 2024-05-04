import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimationPage'),
      ),
      body: const Column(
        children: [
          ColorTweenWidget(),
          SizeTweenWidget(),
          TranslationTweenWidget(),
          FadeTransitionWidget(),
        ],
      ),
    );
  }
}

class ColorTweenWidget extends StatelessWidget {
  const ColorTweenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(begin: Colors.white, end: Colors.red),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      builder: (context, color, child) {
        return Container(
          width: 100,
          height: 100,
          color: color,
        );
      },
    );
  }
}

class SizeTweenWidget extends StatelessWidget {
  const SizeTweenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: SizeTween(begin: const Size(0, 0), end: const Size(100, 100)),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      builder: (context, size, child) {
        return Container(
          width: size!.width,
          height: size.height,
          color: Colors.green,
        );
      },
    );
  }
}

class TranslationTweenWidget extends StatefulWidget {
  const TranslationTweenWidget({super.key});

  @override
  State<TranslationTweenWidget> createState() => _TranslationTweenWidgetState();
}

class _TranslationTweenWidgetState extends State<TranslationTweenWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      ),
    );
  }
}

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({super.key});

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: Colors.orange,
        width: 100,
        height: 100,
      ),
    );
  }
}
