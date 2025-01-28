import 'package:flutter/material.dart';
import 'package:katseyy/categories pages/notepad.dart';
import 'package:katseyy/categories pages/diary.dart';
import 'package:katseyy/categories pages/mycalendar.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2E9), // Light beige background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Text without padding
            Container(
              width: MediaQuery.of(context).size.width, // Makes it fill the screen width
              height: 180, // Adjust the height as needed
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                color:  Color.fromARGB(255, 74, 69, 144), // Purple background
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Hello, Lynx", // Greeting message
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Padding for the rest of the content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section title for "My Apps"
                  const Text(
                    "My Apps",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 9),
                ],
              ),
            ),

            // Center-aligned row for App 1 and Apps 2 & 3
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align the items at the top
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between to align left and right
                children: [
                  // App 1
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          _buildApp1(),
                          const SizedBox(height: 9), // Space between apps
                        ],
                      ),
                    ),
                  ),

                  // Column for App 2 and App 3
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align App 2 and App 3 to the start
                        children: [
                          _buildApp2(),
                          const SizedBox(height: 9), // Space between apps
                          _buildApp3(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 9),

            // App 4 container aligned to the left and right
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildApp4()),
                  const SizedBox(width: 16), // Add space between App 4 and the right edge
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // App 1 container
  Widget _buildApp1() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DiaryPage()), // Ensure you're creating an instance of NoteListPage
      );
    },
      child: SizedBox(
        height: 278, // Unique height
        width: 170,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'App 1',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // App 2 container
  Widget _buildApp2() {
    return GestureDetector(
      onTap: () {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NoteListPage()), // Ensure you're creating an instance of NoteListPage
      );
    },
      child: SizedBox(
        height: 135, // Unique height
        width: 170,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'App 2',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // App 3 container
  Widget _buildApp3() {
    return GestureDetector(
      onTap: () {
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const CalendarPage()), // Ensure you're creating an instance of NoteListPage
      );
    },
      child: SizedBox(
        height: 135, // Unique height
        width: 170,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'App 3',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // App 4 container
  Widget _buildApp4() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppDetailPage(title: 'App 4')),
        );
      },
      child: SizedBox(
        height: 200, // Unique height
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'App 4',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Dummy detail page for navigation
class AppDetailPage extends StatelessWidget {
  final String title;

  const AppDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Details of $title',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
