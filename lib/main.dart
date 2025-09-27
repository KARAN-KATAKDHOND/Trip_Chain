// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/navigation_container.dart'; // New import

// Updated color palette to match the new UI


void main() {
  runApp(const MyApp());
}class AppColors {
  static const Color background = Color(0xFFF6F6F6); // Light Grey
  static const Color primaryText = Color(0xFF2D2D2D); // Dark Charcoal
  static const Color secondaryText = Color(0xFF6E6E6E);
  static const Color accentRed = Color(0xFFE57373); // Reddish-Coral
  static const Color cardBlue = Color(0xFFB0C4DE); // Dusty Blue-Grey
  static const Color iconBackground = Color(0xFFF5E5D5); // Creamy Beige
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Chain', // Renamed
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.accentRed,
        fontFamily: 'Roboto', // Example font, use your preferred one
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.primaryText),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) =>const NavigationContainer(), // New route for the main app
      },
    );
  }
}
