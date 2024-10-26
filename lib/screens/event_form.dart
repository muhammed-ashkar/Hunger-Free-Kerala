import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/database/database.dart';
import 'package:intl/intl.dart';


class Event extends StatefulWidget {
  const Event({super.key});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<Event> {
  final _formKey = GlobalKey<FormState>();
  String _eventType = 'breakfast';
  DateTime? _selectedDate;
  String _address = '';
  String _email = '';
  String _location = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Prepare event data for storage
      Map<String, dynamic> event = {
        'eventType': _eventType,
        'date': _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : '',
        'address': _address,
        'email': _email,
        'location': _location,
      };

      // Store data in SQLite
      await DatabaseHelper().insertEvent(event);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event saved successfully!')),
      );

      // Optionally reset the form
      _formKey.currentState!.reset();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Give Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _eventType,
              decoration: const InputDecoration(labelText: 'Event Type'),
              items: ['breakfast', 'lunch', 'tea', 'dinner']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _eventType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the address.';
                }
                return null;
              },
              onSaved: (value) {
                _address = value!;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the location.';
                }
                return null;
              },
              onSaved: (value) {
                _location = value!;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Date',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
              validator: (value) {
                if (_selectedDate == null) {
                  return 'Please select a date.';
                }
                return null;
              },
              controller: TextEditingController(
                text: _selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                    : '',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}