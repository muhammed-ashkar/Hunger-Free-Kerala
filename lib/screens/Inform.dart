import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  String _eventType = 'breakfast';
  DateTime? _selectedDate;
  String _address = '';
  String _email = '';
  String _location = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle form submission (e.g., send data to server)
      print('Event Type: $_eventType');
      print('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}');
      print('Address: $_address');
      print('Email: $_email');
      print('Location: $_location');
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
    return Scaffold(
      backgroundColor: Colors.black, // Full black background
      appBar: AppBar(
        title: const Text('Event Form'),
        backgroundColor: const Color.fromARGB(153, 219, 0, 0), // Distinct color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Card(
          color: Colors.grey[900], // Darker card background
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Give Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.grey[850], // Dark dropdown color
                    value: _eventType,
                    decoration: const InputDecoration(
                      labelText: 'Event Type',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    items: ['breakfast', 'lunch', 'tea', 'dinner']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: const TextStyle(color: Colors.white),
                              ),
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
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _address = value!;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the location.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 230, 227, 227),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(153, 219, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
