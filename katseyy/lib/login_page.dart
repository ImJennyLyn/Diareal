import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLogin = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 74, 69, 144),
              Color.fromARGB(255, 74, 69, 144),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBF2E9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showLogin = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: showLogin
                                  ? const Color.fromARGB(255, 74, 69, 144)
                                  : Colors.white,
                              foregroundColor:
                                  showLogin ? Colors.white : Colors.black,
                            ),
                            child: const Text('Login'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showLogin = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !showLogin
                                  ? const Color.fromARGB(255, 74, 69, 144)
                                  : Colors.white,
                              foregroundColor:
                                  !showLogin ? Colors.white : Colors.black,
                            ),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      showLogin ? _buildLoginForm() : _buildSignUpForm(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Define your purple color here
  static const Color purpleColor = Color.fromARGB(255, 74, 69, 144);

  // Login form widget
  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            filled: true, // Enable the filled property
            fillColor: Colors.white, // Set the background color to white
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: purpleColor), // Set the border color to purple
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            filled: true, // Enable the filled property
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: purpleColor),
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => loginUser(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 74, 69, 144),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          child: Container(
            width: 400,
            height: 50,
            alignment: Alignment.center, 
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white), 
            ),
          ),
        ),
      ],
    );
  }

  // Sign-up form widget
  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          controller: fullNameController,
          decoration: const InputDecoration(
            labelText: 'User Name',
            filled: true, 
            fillColor: Colors.white, 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: purpleColor), 
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            filled: true, 
            fillColor: Colors.white, 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: purpleColor), 
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            filled: true, // Enable the filled property
            fillColor: Colors.white, // Set the background color to white
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: purpleColor), // Set the border color to purple
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => registerUser(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 74, 69, 144),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          child: Container(
            width: 400,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

   //  register user
  Future<void> registerUser() async {
    var url = Uri.parse('http://192.168.18.27/KATSEYY/register.php'); 
    var response = await http.post(url, body: {
      'full_name': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    var data = json.decode(response.body);
    if (data['success']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }

 //  login user
Future<void> loginUser() async {
  var url = Uri.parse('http://192.168.18.27/KATSEYY/login.php'); 
  var response = await http.post(url, body: {
    'email': emailController.text,
    'password': passwordController.text,
  });

  var data = json.decode(response.body);
  
  if (data['success']) {
    // Navigate to the home page if login is successful
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()), // Replace with your home page widget
    );
  } else {
    // Show error message if login is invalid
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data['message'])));
  }
}
} 