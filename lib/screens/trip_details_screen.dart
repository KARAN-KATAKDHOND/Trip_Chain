import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_chain/main.dart';
import 'package:trip_chain/models/trip_user_model.dart';

class TripDetailsScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        backgroundColor: AppColors.backgroundMain,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDetailCard(context),
          const SizedBox(height: 16),
          _buildAdditionalInfoCard(context),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              context,
              icon: Icons.location_on_outlined,
              label: 'Origin',
              value: trip.origin,
            ),
            const Divider(height: 30),
            _buildDetailRow(
              context,
              icon: Icons.flag_outlined,
              label: 'Destination',
              value: trip.destination,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildDetailRow(
              context,
              icon: Icons.calendar_today_outlined,
              label: 'Date',
              value: DateFormat.yMMMMd().format(trip.departureTimestamp),
            ),
            const Divider(height: 30),
            _buildDetailRow(
              context,
              icon: Icons.access_time,
              label: 'Time',
              value: DateFormat.jm().format(trip.departureTimestamp),
            ),
            const Divider(height: 30),
            _buildDetailRow(
              context,
              icon: transportModeIcons[trip.transportMode]!,
              label: 'Transport Mode',
              value: trip.transportMode.name.capitalize(),
            ),
            const Divider(height: 30),
            _buildDetailRow(
              context,
              icon: Icons.work_outline,
              label: 'Purpose',
              value: trip.tripPurpose.name.capitalize(),
            ),
            const Divider(height: 30),
              _buildDetailRow(
              context,
              icon: Icons.group_outlined,
              label: 'Accompanying Travellers',
              value: trip.accompanyingTravellers.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Helper extension to capitalize strings
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

