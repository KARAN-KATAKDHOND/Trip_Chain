import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:trip_chain/main.dart';
import 'package:trip_chain/models/trip_user_model.dart';

class NewTrip extends StatefulWidget {
  final void Function(Trip trip) onAddTrip;
  const NewTrip({super.key, required this.onAddTrip});
  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _travellersController = TextEditingController(text: '0');
  bool _isGettingLocation = false;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TransportMode _selectedTransportMode = TransportMode.bus;
  TripPurpose _selectedTripPurpose = TripPurpose.work;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _travellersController.dispose();
    super.dispose();
  }

  // --- Geolocation Logic ---
  Future<void> _getCurrentLocation() async {
    setState(() => _isGettingLocation = true);
    // ... existing location logic ...
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        _originController.text = "${placemark.street}, ${placemark.locality}";
      }
    } catch (e) {
      print("Error getting location: $e");
    } finally {
      if (mounted) setState(() => _isGettingLocation = false);
    }
  }

  // --- Date & Time Picker Logic ---
  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _presentTimePicker() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );
    if (pickedTime != null) {
      setState(() => _selectedTime = pickedTime);
    }
  }

  // --- New: Auto-fill Current Date and Time ---
  void _autoFillCurrentDateTime() {
    final now = DateTime.now();
    setState(() {
      _selectedDate = now;
      _selectedTime = TimeOfDay.fromDateTime(now);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Current date and time have been set.')),
    );
  }

  // --- Form Submission Logic ---
  void _submitTripData() {
    final enteredTravellers = int.tryParse(_travellersController.text);

    if (_originController.text.trim().isEmpty ||
        _destinationController.text.trim().isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Incomplete Information'),
          content: const Text(
            "Please fill out all required fields, including origin, destination, date, and time.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final departureTimestamp = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    widget.onAddTrip(
      Trip(
        origin: _originController.text,
        destination: _destinationController.text,
        departureTimestamp: departureTimestamp,
        transportMode: _selectedTransportMode,
        tripPurpose: _selectedTripPurpose,
        accompanyingTravellers: enteredTravellers ?? 0,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a New Trip',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _originController,
                  decoration: const InputDecoration(labelText: 'Origin'),
                ),
              ),
              _isGettingLocation
                  ? const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.my_location,
                        color: AppColors.secondary,
                      ),
                      onPressed: _getCurrentLocation,
                      tooltip: 'Use Current Location',
                    ),
            ],
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination (e.g., MGMCET)',
            ),
          ),
          const SizedBox(height: 24),

          // Updated Date and Time section with Auto-Detect Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Departure Time",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton.icon(
                onPressed: _autoFillCurrentDateTime,
                icon: const Icon(Icons.access_time_filled, size: 18),
                label: const Text("Use Current Time"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDateTimePicker(
                  label: 'Date',
                  value: _selectedDate != null
                      ? DateFormat.yMd().format(_selectedDate!)
                      : 'Select Date',
                  onTap: _presentDatePicker,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateTimePicker(
                  label: 'Time',
                  value: _selectedTime?.format(context) ?? 'Select Time',
                  onTap: _presentTimePicker,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _buildDropdown<TransportMode>(
                  label: 'Transport',
                  value: _selectedTransportMode,
                  items: TransportMode.values,
                  onChanged: (val) =>
                      setState(() => _selectedTransportMode = val!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown<TripPurpose>(
                  label: 'Purpose',
                  value: _selectedTripPurpose,
                  items: TripPurpose.values,
                  onChanged: (val) =>
                      setState(() => _selectedTripPurpose = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _travellersController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Accompanying Travellers',
              prefixIcon: Icon(Icons.group_outlined),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitTripData,
                child: const Text('Save Trip'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widgets remain the same
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                (item as Enum).name[0].toUpperCase() +
                    (item as Enum).name.substring(1),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
