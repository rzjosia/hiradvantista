import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/dashboard_controller.dart';
import 'menu_items.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  final PageController pageController;

  const BottomNavigationWidget({required this.pageController, super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(dashboardControllerProvider);

    return AnimatedBottomNavigationBar(
      icons: Menu.items.map((e) => e.icon).toList(),
      onTap: _onTap,
      activeIndex: position,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      activeColor: Colors.white,
      inactiveColor: Colors.white54,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _onTap(int index) {
    ref.read(dashboardControllerProvider.notifier).setPosition(index);
    widget.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
