import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trip_user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signUpWithEmail(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _createUserProfile(userCredential.user!, fullName);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error: ${e.message}");
      return null;
    }
  }

  Future<void> _createUserProfile(User user, String fullName) async {
    final userModel = UserModel(
      uid: user.uid,
      email: user.email!,
      displayName: fullName,
      createdAt: DateTime.now(),
    );
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toFirestore());
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Sign In Error: ${e.message}");
      return null;
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Stream<UserModel?> getUserStream() {
    if (currentUser == null) return Stream.value(null);
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .map((snap) => snap.exists ? UserModel.fromFirestore(snap) : null);
  }

  Future<void> addTrip(Trip trip) async {
    if (currentUser == null) return;
    // Add trip to sub-collection
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('trips')
        .add(trip.toFirestore());
    // Update user points
    await _firestore.collection('users').doc(currentUser!.uid).update({
      'totalPoints': FieldValue.increment(50), // Award 50 points per trip
    });
  }

  Stream<List<Trip>> getTripsStream() {
    if (currentUser == null) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('trips')
        .orderBy('departureTimestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Trip.fromFirestore(doc)).toList(),
        );
  }

  Future<void> deleteTrip(String tripId) async {
    if (currentUser == null) return;
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('trips')
        .doc(tripId)
        .delete();
  }
}
