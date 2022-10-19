import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Config/size_config.dart';
import '../Widgets/custom_bottom_navigation_bar.dart';
import 'Home/home_screen.dart';
import 'Location/location_screen.dart';
import 'Settings/settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages = [
    LocationScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];

  int _selectedPageIndex = 1;

  onBottomIconPressed(int index) {
    print(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onBottomIconPressed: onBottomIconPressed,
        selectedIndex: _selectedPageIndex,
      ),
    );
  }
}
