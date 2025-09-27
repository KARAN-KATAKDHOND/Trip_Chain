import 'package:flutter/material.dart';
import 'package:trip_chain/models/trip_user_model.dart';
import 'package:trip_chain/services/firebase_service.dart';
import 'package:trip_chain/screens/widgets/trip_card.dart';
import 'package:trip_chain/main.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('My Trips')),
      body: StreamBuilder<List<Trip>>(
        stream: firebaseService.getTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Trips Yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Your recorded journeys will appear here.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          final trips = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return TripCard(
                trip: trips[index],
                onDismissed: (tripId) {
                  firebaseService.deleteTrip(tripId);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Trip deleted")));
                },
              );
            },
          );
        },
      ),
    );
  }
}
