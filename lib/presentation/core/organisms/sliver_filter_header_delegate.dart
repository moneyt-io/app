import 'package:flutter/material.dart';
import 'dart:ui';

class SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final bool blur;

  SliverFilterHeaderDelegate({
    required this.child,
    required this.height,
    this.blur = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final backgroundColor = blur
        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85)
        : Theme.of(context).scaffoldBackgroundColor;

    final content = Container(
      color: backgroundColor,
      child: child,
    );

    if (blur) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: content,
        ),
      );
    }

    return content;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverFilterHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.blur != blur;
  }
}
