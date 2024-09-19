import 'package:flutter/material.dart';

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture and Name
              CircleAvatar(
                radius: 60,
                backgroundImage: const NetworkImage('https://example.com/profile_pic.jpg'), // Replace with your image
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Victoria Heard',
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), // Changed text color to black for readability
              ),
              const Text(
                'Active since - Jul, 2019',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Personal Information
              const Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.edit, color: Colors.black), // Edit Icon
                              SizedBox(width: 4), // Spacing between icon and text
                              Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text('heard_j@gmail.com', style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone, color: Colors.black),
                        title: Text('9898712132', style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        leading: Icon(Icons.web, color: Colors.black),
                        title: Text('www.randomweb.com', style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.black),
                        title: Text('Antigua', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Utilities Section
              const Column(
                children: [
                  Text(
                    'Utilities',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  UtilityTile(icon: Icons.download, label: 'Downloads'),
                  UtilityTile(icon: Icons.analytics, label: 'Usage Analytics'),
                  UtilityTile(icon: Icons.help, label: 'Ask Help-Desk'),
                  UtilityTile(icon: Icons.logout, label: 'Log-Out'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// UtilityTile Widget
class UtilityTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const UtilityTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(label, style: const TextStyle(color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {},
      ),
    );
  }
}
