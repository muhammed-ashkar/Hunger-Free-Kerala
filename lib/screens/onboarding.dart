import 'package:flutter/material.dart';
import 'package:hunger_free_kerala/screens/home_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboarding.jpeg'), // Replace with your actual image path
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0), // Increased bottom padding to move button up
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                    foregroundColor: Colors.white, // Text color
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomeScreen()),
                    );
                  },
                  child: const Text('Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
