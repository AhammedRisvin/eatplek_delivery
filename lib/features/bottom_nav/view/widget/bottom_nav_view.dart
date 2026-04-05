import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../earnings/view/earnings_view.dart';
import '../../../history/view/history_view.dart';
import '../../../home/views/home_view.dart';
import '../../../profile/view/profile_view.dart';
import '../curved_bottom_nav.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _currentIndex = 0;

  // Gradient background matching Figma: #B4D6FF left to right at 30%
  static const _bgGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 198, 222, 251),
      Color.fromARGB(255, 232, 241, 253)
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        decoration: const BoxDecoration(gradient: _bgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: IndexedStack(
            index: _currentIndex,
            children: const [
              HomeView(),
              EarningsView(),
              HistoryView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: CurvedBottomNav(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
          ),
        ),
      ),
    );
  }
}
