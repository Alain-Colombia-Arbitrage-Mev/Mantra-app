import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'home_tab.dart';
import 'meditate_tab.dart';
import 'alarms_tab.dart';
import 'astro_tab.dart';
import 'profile_tab.dart';

/// MainShell — the root scaffold after onboarding.
/// Hosts the 5 bottom-nav tabs. Sub-screens (Marketplace, MirrorHours)
/// are pushed on top via Navigator/GoRouter and do not show this nav.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  static const List<Widget> _tabs = [
    HomeTab(),
    MeditateTab(),
    AlarmsTab(),
    AstroTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor is transparent so each tab's ScreenBg shows through.
      backgroundColor: Colors.black,
      extendBody: true,
      // IndexedStack keeps all tabs alive and avoids re-init on switching.
      body: IndexedStack(
        index: _currentTab,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentTab,
        onTap: (i) => setState(() => _currentTab = i),
      ),
    );
  }
}
