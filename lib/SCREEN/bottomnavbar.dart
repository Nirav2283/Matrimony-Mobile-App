import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:matrimony/SCREEN/dashboard_screen.dart';
import 'package:matrimony/SCREEN/userlist.dart';
import 'package:matrimony/SCREEN/add_user.dart';
import 'package:matrimony/SCREEN/about_us.dart';
import 'package:matrimony/SCREEN/favourites.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _activeIndex = 0; // Track the active tab index
  final List<Widget> _pages = [
    DashboardScreen(),
    Favourites(),
    AddUser(),
    Userlist(),
    AboutUs(),
  ];

  // Handle the change of the tab
  void _handleIndexChanged(int index) {
    setState(() {
      _activeIndex = index; // Update the active tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Prevent navbar from overlapping content
      body: _pages[_activeIndex], // Show the active page
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _activeIndex, // The current active tab
        onTap: _handleIndexChanged, // Callback when a tab is selected
        indicatorColor: Colors.white, // Color for the selected tab indicator
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home,
            selectedColor: Colors.orange, // Active tab icon color
          ),
          CrystalNavigationBarItem(
            icon: Icons.favorite,
            selectedColor: Colors.pink,
          ),
          CrystalNavigationBarItem(
            icon: Icons.add,
            selectedColor: Colors.green,
          ),
          CrystalNavigationBarItem(
            icon: Icons.list,
            selectedColor: Colors.blue,
          ),
          CrystalNavigationBarItem(
            icon: Icons.info,
            selectedColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
