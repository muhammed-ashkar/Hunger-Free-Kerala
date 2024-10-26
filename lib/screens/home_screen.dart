import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/screens/event_screen.dart';
import 'package:hunger_free_kerala/screens/information.dart';
import 'package:hunger_free_kerala/screens/search.dart'; 
import 'package:hunger_free_kerala/screens/instructions.dart';
import 'package:hunger_free_kerala/screens/saved.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
           // Replace with your Home Content widget
      const Search(),                // Replace with your Search widget
      InformScreen(),                // This is where you add event details
      EventsScreen(),                // This is the screen showing added events
      const Instructions(),           // Replace with your Instructions widget
      const Saved(),                 // Replace with your Saved widget
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hunger Free Kerala'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Inform',           // Change the label to "Inform"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Instructions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
