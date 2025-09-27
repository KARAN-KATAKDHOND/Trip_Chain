// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildAppBar(),
            const SizedBox(height: 24),
            _buildGreetingCard("Karan"),
            const SizedBox(height: 20),
            _buildMainActionCard(),
            const SizedBox(height: 20),
            _buildPointsCard(1250, "Urban Explorer"),
            const SizedBox(height: 20),
            _buildTripHistoryCard("Yesterday to MGMCET", "10 km"),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Trip Chain', // Renamed
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.secondaryText,
            size: 28,
          ),
          onPressed: () {
            // TODO: Handle settings tap
          },
        ),
      ],
    );
  }

  Widget _buildGreetingCard(String name) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Text(
          'Good Evening, $name!',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildMainActionCard() {
    return Card(
      color: AppColors.cardBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Icon(Icons.directions_walk, color: Colors.white, size: 40),
            SizedBox(height: 12),
            Text(
              'Ready to track your next journey.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(int points, String nextBadge) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Points:',
                      style: TextStyle(color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$points',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Badge:',
                      style: TextStyle(color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nextBadge,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.6, // Example progress
                minHeight: 8,
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentRed),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripHistoryCard(String title, String subtitle) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppColors.secondaryText),
                    ),
                  ],
                ),
                SizedBox(width: 50,height: 5,),
                IconButton(onPressed: (){}, 
                icon: Icon(
                  Icons.motorcycle,
                )
                
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
