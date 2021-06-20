import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> scaleAnimation1;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

    scaleAnimation1 =
        CurvedAnimation(parent: controller, curve: Curves.easeInQuart);

    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller, curve: Curves.slowMiddle));

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Align(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: scaleAnimation1,
          child: ScaleTransition(
            scale: scaleAnimation1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
