import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:katseyy/login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2E9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins', // Apply Poppins font
                    ),
                  ),
                  Text(
                    'Diareal',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 69, 144),
                      fontFamily: 'Poppins', // Apply Poppins font
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Diareal blends your daily life with your personal diary. Capture moments with photos, jot down thoughts, schedule events, and unwind with mini mind games—all in one seamless experience',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w200, // Light text
                      fontFamily: 'Poppins', // Apply Poppins font
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            // Add Lottie animation in the center
            Center(
              child: Lottie.asset(
                'assets/welc.json', // Ensure this path is correct
                height: 200, // Increase the size for better visibility
                width: 200,
                fit: BoxFit.contain, // Use contain to avoid cropping
              ),
            ),
            Center(
              child: SizedBox(
                width: 300, // Set the width of the button
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page and remove GetStartedPage from the stack
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 74, 69, 144), // Button color
                    padding: const EdgeInsets.symmetric(vertical: 20), // Adjust height through padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Make button rounded
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins', // Apply Poppins font
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
