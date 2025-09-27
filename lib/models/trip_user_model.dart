//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Enum for different modes of transport
enum TransportMode { walk, bike, car, bus, train, other }

// Enum for the purpose of the trip
enum TripPurpose { work, education, leisure, personal, other }

// Icons for the enums to be used in the UI
const transportModeIcons = {
  TransportMode.walk: Icons.directions_walk,
  TransportMode.bike: Icons.directions_bike,
  TransportMode.car: Icons.directions_car,
  TransportMode.bus: Icons.directions_bus,
  TransportMode.train: Icons.tram,
  TransportMode.other: Icons.public,
};

// Main data model for a single trip
class Trip {
  Trip({
    required this.origin,
    required this.destination,
    required this.departureTimestamp,
    required this.transportMode,
    required this.tripPurpose,
    this.accompanyingTravellers = 0,
    this.id,
  });

  final String? id;
  final String origin;
  final String destination;
  final DateTime departureTimestamp;
  final TransportMode transportMode;
  final TripPurpose tripPurpose;
  final int accompanyingTravellers;
}

// Data model for the user profile
class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.totalPoints = 0,
  });

  final String uid;
  final String email;
  final String? displayName;
  final int totalPoints;
}
