import 'dart:io';

import 'package:flutter/material.dart';

import '../../screens/home/view/home_screen.dart';
import '../../screens/history/view/history_screen.dart';
import '../../screens/profile/view/profile_screen.dart';
import '../../screens/services/view/services_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/application_localization.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/dialog_helper.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  static Widget builder(BuildContext context, {int initialIndex = 0}) {
    return MainTabsScreen(initialIndex: initialIndex);
  }

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _setIndex(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainTabsScope(
      currentIndex: _currentIndex,
      onTabSelected: _setIndex,
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            final shouldExit =
                await DialogHelper.exitAppConfirmationDialog(context);
            if (shouldExit == true && context.mounted) {
              exit(0);
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: const [
                  _HomeTab(),
                  _ServicesTab(),
                  _HistoryTab(),
                  _ProfileTab(),
                ],
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: BottomNavBar(
                  currentIndex: _currentIndex,
                  onItemSelected: _setIndex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainTabsScope extends InheritedWidget {
  const MainTabsScope({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required super.child,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  static MainTabsScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainTabsScope>();
  }

  @override
  bool updateShouldNotify(MainTabsScope oldWidget) {
    return oldWidget.currentIndex != currentIndex;
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return HomeScreen.builder(context);
  }
}

class _ServicesTab extends StatelessWidget {
  const _ServicesTab();

  @override
  Widget build(BuildContext context) {
    return ServicesScreen.builder(context);
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    return HistoryScreen.builder(context);
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return ProfileScreen.builder(context);
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

