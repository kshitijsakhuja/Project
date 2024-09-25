import 'package:flutter/material.dart';
import 'ride_history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            print('Back button pressed');
          },
        ),
      ),
      body: Column(
        children: [
          // Enhanced Header Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[100]!, Colors.green[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    // Enhanced drop shadow around the profile picture
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 8,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 55, // Increased size
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 50, // Inner circle size
                          backgroundImage: AssetImage('assets/images.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          print('Edit Profile tapped');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green[800],
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                // Wrap the Column in Flexible to prevent overflow
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Kshitij', // Changed name here
                        style: TextStyle(
                          fontSize: 36, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                        overflow: TextOverflow.ellipsis, // Prevent text overflow
                      ),
                      const SizedBox(height: 0), // Reduced spacing
                      Text(
                        'Welcome Back!', // Changed message here
                        style: TextStyle(
                          fontSize: 24, // Slightly larger font size
                          color: Colors.green[600],
                        ),
                        overflow: TextOverflow.ellipsis, // Prevent text overflow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildListTile(Icons.history, 'Ride History', context), // Pass context here
                const SizedBox(height: 12),
                buildListTile(Icons.local_offer, 'Offers', context),
                const SizedBox(height: 12),
                buildListTile(Icons.card_giftcard, 'Refer & Earn ₹300', context, isNew: true),
                const SizedBox(height: 12),
                buildListTile(Icons.attach_money, 'Ride Charges', context),
                const SizedBox(height: 12),
                buildListTile(Icons.settings, 'Settings', context),
                const SizedBox(height: 12),
                buildListTile(Icons.location_on, 'Request a ZoopE Centre', context),
                const SizedBox(height: 12),
                buildListTile(Icons.support_agent, 'Customer Care', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget to Build List Tiles
  Widget buildListTile(IconData icon, String title, BuildContext context, {bool isNew = false}) {
    return GestureDetector(
      onTap: () {
        if (title == 'Ride History') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RideHistoryApp()), // Navigate to RideHistoryPage
          );
        }
        print('$title tapped');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 34,
            color: Colors.green[700],
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          trailing: isNew
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}
