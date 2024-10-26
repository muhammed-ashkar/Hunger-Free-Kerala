import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/database/database_helper.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        iconTheme: const IconThemeData(color: Colors.white), // Set the back button color to white
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events registered.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final event = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['venue'] ?? 'Unknown Venue',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: ${event['date'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[700],
                                ),
                              ),
                              Text(
                                'Time: ${event['time'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange[600],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.brown[800],
                            ),
                            onPressed: () {
                              // Save event when the icon is tapped
                              DatabaseHelper().insertEvent(event);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Event saved!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Text(
                        'Address: ${event['address'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
                        ),
                      ),
                      Text(
                        'Location: ${event['location'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[600],
                        ),
                      ),
                      Text(
                        'Phone: ${event['phone'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red[600],
                        ),
                      ),
                      Text(
                        'Category: ${event['category'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
