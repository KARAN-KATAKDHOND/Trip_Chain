import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trip_chain/main.dart';
import 'package:trip_chain/models/trip_user_model.dart';
import 'package:trip_chain/services/firebase_service.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('My Analytics')),
      body: StreamBuilder<List<Trip>>(
        stream: firebaseService.getTripsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No trip data to analyze yet."));
          }
          final trips = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildModeDistributionCard(context, trips),
              const SizedBox(height: 20),
              _buildPurposeDistributionCard(context, trips),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModeDistributionCard(BuildContext context, List<Trip> trips) {
    final Map<TransportMode, int> modeCounts = {};
    for (var trip in trips) {
      modeCounts[trip.transportMode] =
          (modeCounts[trip.transportMode] ?? 0) + 1;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transport Modes",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: modeCounts.entries.map((entry) {
                    return PieChartSectionData(
                      color: _getColorForMode(entry.key),
                      value: entry.value.toDouble(),
                      title:
                          '${entry.key.name[0].toUpperCase()}${entry.key.name.substring(1)}',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurposeDistributionCard(BuildContext context, List<Trip> trips) {
    // Similar logic as above, but creates a BarChart for TripPurpose.
    // Omitted for brevity but would follow the same data processing pattern.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trip Purposes",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Text("Bar chart for trip purposes would be here."),
          ],
        ),
      ),
    );
  }

  Color _getColorForMode(TransportMode mode) {
    switch (mode) {
      case TransportMode.car:
        return AppColors.primary;
      case TransportMode.bus:
        return AppColors.accent;
      case TransportMode.walk:
        return AppColors.secondary;
      case TransportMode.bike:
        return Colors.green;
      case TransportMode.train:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
