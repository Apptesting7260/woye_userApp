import 'package:flutter/material.dart';

class SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverPinnedHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child is PreferredSizeWidget
      ? (child as PreferredSizeWidget).preferredSize.height
      : kToolbarHeight;

  @override
  double get minExtent => maxExtent;

  @override
  bool shouldRebuild(covariant SliverPinnedHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}