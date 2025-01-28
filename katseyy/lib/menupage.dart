import 'package:flutter/material.dart';
import 'package:katseyy/login_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
          'Settings',
          style: TextStyle(color:Color.fromARGB(255, 74, 69, 144),), // Change the color here
        ),
        backgroundColor: const Color(0xFFFBF2E9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Color.fromARGB(255, 74, 69, 144),),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFFBF2E9), // Light beige background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Edit Profile
            _buildMenuOption(
              context,
              icon: Icons.person,
              title: 'Edit Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileSettingsPage()),
                );
              },
            ),
            _buildDivider(),
            // Change Password
            _buildMenuOption(
              context,
              icon: Icons.lock,
              title: 'Change Password',
              onPressed: () {
                // Navigate to Change Password Page
              },
            ),
            _buildDivider(),
            // About
            _buildMenuOption(
              context,
              icon: Icons.info,
              title: 'About',
              onPressed: () {
                // Navigate to About Page
              },
            ),
            _buildDivider(),
            // Logout in red
           _buildMenuOption(
  context,
  icon: Icons.logout,
  title: 'Log Out',
  titleColor: Colors.red,
  iconColor: Colors.red,
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to Login Page
    );
  },
),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onPressed,
        Color titleColor = const Color.fromARGB(255, 65, 63, 90),
        Color iconColor = const Color.fromARGB(255, 65, 63, 90),
      }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontSize: 18),
      ),
      onTap: onPressed,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
    );
  }
}

// Placeholder for Profile Settings Page
class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: const Center(child: Text('Profile Settings Page')),
    );
  }
}

// Placeholder for Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Page')),
    );
  }
}
