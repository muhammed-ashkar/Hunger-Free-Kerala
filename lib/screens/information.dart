import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/database/database.dart';

class InformScreen extends StatefulWidget {
  @override
  _InformScreenState createState() => _InformScreenState();
}

class _InformScreenState extends State<InformScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventTypeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _addEvent() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newEvent = {
        'eventType': _eventTypeController.text,
        'date': _dateController.text,
        'location': _locationController.text,
        'address': _addressController.text,
        'email': _emailController.text,
      };

      await DatabaseHelper().insertEvent(newEvent);

      // Clear text fields after submission
      _eventTypeController.clear();
      _dateController.clear();
      _locationController.clear();
      _addressController.clear();
      _emailController.clear();

      // Optionally, show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _eventTypeController,
                decoration: InputDecoration(labelText: 'Event Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEvent,
                child: Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
