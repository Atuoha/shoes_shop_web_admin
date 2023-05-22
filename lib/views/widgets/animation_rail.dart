import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/constants/color.dart';

class AnimatedRail extends StatelessWidget {
  const AnimatedRail({Key? key, required this.widget, required this.fnc})
      : super(key: key);
  final Widget widget;
  final VoidCallback fnc;

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => SizedBox(
        height: 56,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: FloatingActionButton.extended(
            backgroundColor: accentColor,
            onPressed: () => fnc(),
            label: widget,
            isExtended:  animation.status != animation.isDismissed,
          ),
        ),
      ),
    );
  }
}