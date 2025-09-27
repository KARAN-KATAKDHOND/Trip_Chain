// lib/screens/navigation_container.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'trips_screen.dart';
import 'profiles_screen.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import '../main.dart'; // For AppColors



class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TripsScreen(),
    ProfileScreen(),
    SignUpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Handle 'Add Trip' action
        },
        backgroundColor: AppColors.accentRed,
        foregroundColor: Colors.white,
        elevation: 4.0,
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 'Home', 0),
              // The middle item is a placeholder for the FAB
              const SizedBox(width: 40),
              _buildNavItem(Icons.map_outlined, 'Trips', 1),
              _buildNavItem(Icons.person_outline, 'Profile', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    // For Trips and Profile, adjust alignment to space them correctly from the FAB
    MainAxisAlignment topleft = (index == 1 || index == 2)
        ? MainAxisAlignment.end
        : MainAxisAlignment.start;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.accentRed : AppColors.secondaryText,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? AppColors.accentRed
                    : AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
