import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

class ScrollComponent extends StatelessWidget {
  const ScrollComponent({
    super.key,
    required this.child,
    required this.verticalScrollController,
    required this.horizontalScrollController,
  });

  final Widget child;
  final ScrollController verticalScrollController;
  final ScrollController horizontalScrollController;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollbar(
      underColor: Colors.blueGrey.withOpacity(0.3),
      sliderDefaultColor: Colors.grey.withOpacity(0.7),
      sliderActiveColor: Colors.grey,
      controller: verticalScrollController,
      child: AdaptiveScrollbar(
        controller: horizontalScrollController,
        position: ScrollbarPosition.bottom,
        underColor: Colors.blueGrey.withOpacity(0.3),
        sliderDefaultColor: Colors.grey.withOpacity(0.7),
        sliderActiveColor: Colors.grey,
        child: SingleChildScrollView(
          controller: verticalScrollController,
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              controller: horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: child),
        ),
      ),
    );
  }
}
