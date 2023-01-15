import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_search_delegate_widget.dart';

import '../controller/dashboard_controller.dart';
import '../widget/bottom_navigation_widget.dart';
import '../widget/menu_items.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final Widget child;

  const DashboardScreen({required this.child, super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: Menu.items[position].screen,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: HymnSearchDelegateWidget(),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
