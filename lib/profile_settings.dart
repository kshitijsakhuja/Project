import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      themeMode: ThemeMode.system, // Adjust based on user preference
      home: const ProfileSettingsPage(),
    );
  }
}

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool pushNotifications = true;
  bool languagePreference = true; // For example, true for English
  bool darkMode = false; // For example, false for Light Mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // This will take the user back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildAccountSection(),
            const SizedBox(height: 20),
            _buildPasswordSection(),
            const SizedBox(height: 20),
            _buildNotificationSection(),
            const SizedBox(height: 20),
            _buildPreferencesSection(),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }


  // Profile header with profile picture and name
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images.png'), // Add your asset image
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Functionality to change profile picture
                    _showProfilePictureChangeDialog();
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Kshitij',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Kshitij@gmail.com',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Function to show a dialog for changing profile picture
  void _showProfilePictureChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Profile Picture'),
          content: const Text('Functionality to change the profile picture will go here.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Account information section
  Widget _buildAccountSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.person, 'Username', 'Kshitij'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.email, 'Email', 'Kshitij@gmail.com'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.phone, 'Phone Number', '+91 123 456 7890'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Functionality to edit account details
                _showEditAccountDialog();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text('Edit Details'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog for editing account details
  void _showEditAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Account Details'),
          content: const Text('Functionality to edit account details will go here.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Password change section
  Widget _buildPasswordSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.lock, 'Current Password', '********'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.lock_outline, 'New Password', '********'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.lock_outline, 'Confirm Password', '********'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Functionality to change password
                _showChangePasswordDialog();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog for changing password
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: const Text('Functionality to change password will go here.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Notification settings section
  Widget _buildNotificationSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildSwitchTile(Icons.notifications, 'Email Notifications', emailNotifications),
            _buildSwitchTile(Icons.sms, 'SMS Notifications', smsNotifications),
            _buildSwitchTile(Icons.notifications_active, 'Push Notifications', pushNotifications),
          ],
        ),
      ),
    );
  }

  // Preferences section with additional options
  Widget _buildPreferencesSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 10),
            _buildSwitchTile(Icons.language, 'Language Preference', languagePreference),
            _buildSwitchTile(Icons.dark_mode, 'Dark Mode', darkMode, onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  // Build individual information rows
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.greenAccent),
        const SizedBox(width: 10),
        Expanded(child: Text('$title: $value')),
      ],
    );
  }

  // Build switch tiles for preferences
  Widget _buildSwitchTile(IconData icon, String title, bool value, {ValueChanged<bool>? onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.greenAccent),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged ?? (newValue) {
            setState(() {
              value = newValue;
            });
          },
          activeColor: Colors.greenAccent,
        ),
      ],
    );
  }

  // Logout button
  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Functionality for logout
        _showLogoutDialog();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      child: const Text('Logout'),
    );
  }

  // Function to show a dialog for logging out
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Perform logout functionality here (e.g., clearing session data)
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
