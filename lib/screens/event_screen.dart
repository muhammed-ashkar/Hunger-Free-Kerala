import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/database/database.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late Future<List<Map<String, dynamic>>> _events;

  @override
  void initState() {
    super.initState();
    _events = DatabaseHelper().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _events,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return Center(child: Text('No events found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final event = snapshot.data![index];
              return ListTile(
                title: Text(event['eventType']),
                subtitle: Text(
                  'Date: ${event['date']}\nLocation: ${event['location']}\nAddress: ${event['address']}\nEmail: ${event['email']}',
                ),
              );
            },
          );
        }
      },
    );
  }
}
