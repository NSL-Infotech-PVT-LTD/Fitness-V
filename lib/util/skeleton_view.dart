import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadAnimation extends StatefulWidget {
  final Widget child;

  LoadAnimation({@required this.child, Key key}) : super(key: key);

  @override
  _LoadAnimationState createState() => _LoadAnimationState();
}

class _LoadAnimationState extends State<LoadAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Positioned.fill(
          child: ClipRect(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return FractionallySizedBox(
                    widthFactor: .2,
                    alignment: AlignmentGeometryTween(
                      begin: Alignment(-1.0 - .2 * 3, .0),
                      end: Alignment(1.0 + .2 * 3, .0),
                    ).chain(CurveTween(curve: Curves.easeOut)).evaluate(controller),
                    child: child,
                  );
                },
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      colors: const [
                        Color.fromARGB(0, 255, 255, 255),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}