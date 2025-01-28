import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'app_pages/dashboard_page.dart';
import 'app_pages/nf_page.dart';
import 'app_pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To keep track of the current index

  // List of pages for navigation
  final List<Widget> _pages = [
    const DashboardPage(), // Call the HomePage widget
    const NewsFeedPage(), // Call the NewsfeedPage widget
    const ProfilePage(), // Call the ProfilePage widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 2 // Show AppBar only if the current index is not for ProfilePage
          ? PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFBF2E9),
                  // Add a shadow if desired
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     spreadRadius: 2,
                  //     blurRadius: 8,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: false, // Center title false to align with left image
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/diareal.png',
                        height: 40,
                      ),
                      const SizedBox(width: 10), // Space between image and title
                     
                    ],
                  ),
                ),
              ),
            )
          : null, // No AppBar when on ProfilePage
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 25, color: Colors.white),
          Icon(Icons.newspaper, size: 25, color: Colors.white),
          Icon(Icons.person, size: 25, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 74, 69, 144),
        buttonBackgroundColor: const Color.fromARGB(255, 74, 69, 144),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update current index
          });
        },
      ),
    );
  }
}
