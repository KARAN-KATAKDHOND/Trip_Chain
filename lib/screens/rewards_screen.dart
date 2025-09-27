import 'package:flutter/material.dart';
import 'package:trip_chain/main.dart';
// Import your custom models with a prefix to avoid conflicts.
import 'package:trip_chain/models/trip_user_model.dart' as app_models;

class RewardsScreen extends StatelessWidget {
  final int userPoints;

  const RewardsScreen({super.key, required this.userPoints});

  // A mock list of badges. This could be fetched from Firestore in a future version.
  static final List<Map<String, dynamic>> _allBadges = [
    {
      'name': 'First Journey',
      'icon': Icons.flag_outlined,
      'points': 50,
      'description': 'Complete your first trip.',
    },
    {
      'name': 'Urban Explorer',
      'icon': Icons.location_city,
      'points': 500,
      'description': 'Log 10 trips.',
    },
    {
      'name': 'Eco-Warrior',
      'icon': Icons.directions_walk,
      'points': 1000,
      'description': 'Log 5 walk/bike trips.',
    },
    {
      'name': 'Night Owl',
      'icon': Icons.nightlight_round,
      'points': 2000,
      'description': 'Log a trip after 10 PM.',
    },
    {
      'name': 'Weekend Wanderer',
      'icon': Icons.beach_access,
      'points': 5000,
      'description': 'Log trips on 5 different weekends.',
    },
    {
      'name': 'Public Transporter',
      'icon': Icons.directions_bus,
      'points': 7500,
      'description': 'Log 50 bus or train trips.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Now we explicitly use 'app_models.Badge' to refer to YOUR custom Badge class.
    final List<app_models.Badge> badges = _allBadges.map((badgeData) {
      return app_models.Badge(
        name: badgeData['name'],
        icon: badgeData['icon'],
        description: badgeData['description'],
        isUnlocked: userPoints >= badgeData['points'],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Rewards')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          return _BadgeCard(badge: badges[index]);
        },
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final app_models.Badge badge; // Also specify the type here.
  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: badge.isUnlocked
          ? AppColors.backgroundCard
          : AppColors.backgroundMain,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            badge.isUnlocked ? badge.icon : Icons.lock_outline,
            size: 50,
            color: badge.isUnlocked
                ? AppColors.accent
                : AppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          Text(
            badge.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: badge.isUnlocked
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              badge.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
