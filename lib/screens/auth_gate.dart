import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_chain/screens/navigation_container.dart';
import 'package:trip_chain/screens/splash_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If user is logged in, show the main app.
        if (snapshot.hasData) {
          return const NavigationContainer();
        }

        // Otherwise, show the splash/login flow.
        return const SplashScreen();
      },
    );
  }
}
