import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_chain/main.dart';
import 'package:trip_chain/models/trip_user_model.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap; // Callback for when the card is tapped
  final Function(String)? onDismissed;

  const TripCard({super.key, required this.trip, this.onTap, this.onDismissed});

  @override
  Widget build(BuildContext context) {
    // A Dismissible widget allows swipe-to-delete functionality.
    return Dismissible(
      key: ValueKey(trip.id),
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (_) {
        if (onDismissed != null && trip.id != null) {
          onDismissed!(trip.id!);
        }
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: const Icon(Icons.delete_sweep_outlined, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: onTap, // Trigger the tap callback
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    transportModeIcons[trip.transportMode],
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${trip.origin} to ${trip.destination}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat.yMMMd().add_jm().format(
                          trip.departureTimestamp,
                        ),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
