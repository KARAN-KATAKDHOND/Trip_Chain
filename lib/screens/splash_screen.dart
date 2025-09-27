// lib/screens/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart'; // Import to access AppColors

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after a 3-second delay
    Timer(const Duration(seconds: 3), () {
      // Use pushReplacementNamed to prevent user from going back to splash screen
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your App Logo
            Icon(
              Icons.route_outlined,
              size: 80,
              color: AppColors.primaryText,
            ),
            SizedBox(height: 20),
            Text(
              'Trip Chain',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}