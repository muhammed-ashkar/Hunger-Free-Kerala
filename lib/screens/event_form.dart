import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/database/database_helper.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // Controllers for text fields
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Dropdown items
  final List<String> _categories = [
    'Marriage',
    'Funeral',
    'Church Celebration',
    'Temple Celebration',
    'Mosque Event',
    'Community Event'
  ];
  final List<String> _times = ['Breakfast', 'Lunch', 'Dinner'];

  // Selected dropdown values
  String? _selectedCategory;
  String? _selectedTime;

  // Method to handle form submission
  void _submitForm() async {
    String date = _dateController.text;
    String address = _addressController.text;
    String location = _locationController.text;
    String venue = _venueController.text;
    String phone = _phoneController.text;

    // Check if any field is empty
    if (date.isEmpty ||
        address.isEmpty ||
        location.isEmpty ||
        venue.isEmpty ||
        phone.isEmpty ||
        _selectedCategory == null ||
        _selectedTime == null) {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all fields before submitting.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return; // Exit the method early if validation fails
    }

    // Create event map
    Map<String, dynamic> event = {
      'date': date,
      'address': address,
      'location': location,
      'venue': venue,
      'phone': phone,
      'category': _selectedCategory,
      'time': _selectedTime,
    };

    try {
      // Insert into database
      await DatabaseHelper().insertEvent(event);

      // Show confirmation message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Event Registered'),
          content: const Text('Your event has been successfully registered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _clearForm(); // Clear form after registration
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle any errors here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to register event: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Method to clear the form
  void _clearForm() {
    _dateController.clear();
    _addressController.clear();
    _locationController.clear();
    _venueController.clear();
    _phoneController.clear();
    setState(() {
      _selectedCategory = null;
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Event',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date field
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  hintText: 'Enter the event date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Address field
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter the address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Location field
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter the location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Venue field
              TextField(
                controller: _venueController,
                decoration: const InputDecoration(
                  labelText: 'Event Venue',
                  hintText: 'Enter the venue',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Phone number field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter the informer\'s phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Category dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Time dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Event Time',
                  border: OutlineInputBorder(),
                ),
                value: _selectedTime,
                items: _times.map((time) {
                  return DropdownMenuItem(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
