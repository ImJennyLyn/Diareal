import 'package:flutter/material.dart';
import 'loading_page.dart';
import 'login_page.dart'; // Import login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lottie Loading and Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingPage(), // Start with thehh LoadingPage
    );
  }
}
