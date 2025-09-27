import 'package:flutter/material.dart';
import 'package:trip_chain/models/trip_user_model.dart';
//import 'package:intl/intl.dart';

// A stateful widget to capture user input for a new trip.
class NewTrip extends StatefulWidget {
  const NewTrip({super.key, required this.onAddTrip});

  // Callback function to pass the newly created trip back to the parent widget.
  final void Function(Trip trip) onAddTrip;

  @override
  State<NewTrip> createState() {
    return _NewTripState();
  }
}

class _NewTripState extends State<NewTrip> {
  // Controllers for the text input fields.
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _travellersController = TextEditingController(text: '0');

  // State variables for the selected date, time, and categories.
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TransportMode _selectedTransportMode = TransportMode.bus;
  TripPurpose _selectedTripPurpose = TripPurpose.education;

  // Presents the date picker to the user.
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Presents the time picker to the user.
  void _presentTimePicker() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(context: context, initialTime: now);
    setState(() {
      _selectedTime = pickedTime;
    });
  }

  // Validates the user input and submits the form.
  void _submitTripData() {
    final enteredTravellers = int.tryParse(_travellersController.text);
    final travellersAreInvalid =
        enteredTravellers == null || enteredTravellers < 0;

    // Basic validation check.
    if (_originController.text.trim().isEmpty ||
        _destinationController.text.trim().isEmpty ||
        travellersAreInvalid ||
        _selectedDate == null ||
        _selectedTime == null) {
      // Show an error dialog if validation fails.
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            "Please make sure a valid origin, destination, date, and time were entered.",
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

    // Combine date and time into a single DateTime object.
    final departureTimestamp = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    // Call the callback function with the new trip data.
    widget.onAddTrip(
      Trip(
        origin: _originController.text,
        destination: _destinationController.text,
        departureTimestamp: departureTimestamp,
        transportMode: _selectedTransportMode,
        tripPurpose: _selectedTripPurpose,
        accompanyingTravellers: enteredTravellers,
      ),
    );

    // Close the modal after submission.
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _travellersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using LayoutBuilder to handle keyboard overlap
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a New Trip',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Origin and Destination fields
                  TextField(
                    controller: _originController,
                    decoration: const InputDecoration(
                      labelText: 'Origin (e.g., Home)',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: 'Destination (e.g., MGMCET)',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Date and Time pickers
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _presentDatePicker,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Date',
                            ),
                            child: Text(
                              _selectedDate == null
                                  ? 'Select Date'
                                  :DateFormat.yMd().format(_selectedDate!),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: _presentTimePicker,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Time',
                            ),
                            child: Text(
                              _selectedTime == null
                                  ? 'Select Time'
                                  : _selectedTime!.format(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Transport Mode and Trip Purpose dropdowns
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<TransportMode>(
                          value: _selectedTransportMode,
                          decoration: const InputDecoration(
                            labelText: 'Transport',
                          ),
                          items: TransportMode.values
                              .map(
                                (mode) => DropdownMenuItem(
                                  value: mode,
                                  child: Text(
                                    mode.name[0].toUpperCase() +
                                        mode.name.substring(1),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _selectedTransportMode = value!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<TripPurpose>(
                          value: _selectedTripPurpose,
                          decoration: const InputDecoration(
                            labelText: 'Purpose',
                          ),
                          items: TripPurpose.values
                              .map(
                                (purpose) => DropdownMenuItem(
                                  value: purpose,
                                  child: Text(
                                    purpose.name[0].toUpperCase() +
                                        purpose.name.substring(1),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _selectedTripPurpose = value!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Number of accompanying travellers
                  TextField(
                    controller: _travellersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Accompanying Travellers',
                      prefixIcon: Icon(Icons.group),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
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
            ),
          ),
        );
      },
    );
  }
}
