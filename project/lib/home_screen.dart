import 'package:flutter/material.dart';
import 'map_page.dart'; // Import the MapWidget
import 'profile_screen.dart';

class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({super.key});

  @override
  _VehicleSelectionScreenState createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      // Navigate to ProfilePage when avatar is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else {
      // Handle other tabs if necessary (like map, search, favorites)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1DB954), Color(0xFF1DB954)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        elevation: 6,
        shadowColor: Colors.green.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'ZoopE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const MapPage(), // Reusable Google Map Widget
            ),
          ),
          // Vehicle Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  buildVehicleCard(context, 'Road Bike', '300 km', '5 min', '18'),
                  buildVehicleCard(context, 'Mountain Bike', '150 km', '9 min', '27'),
                  buildVehicleCard(context, 'Hybrid Bike', '220 km', '7 min', '35'),
                ],
              ),
            ),
          ),
        ],
      ),
      // BottomNavigationBar with transparent background and shadow
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7), // Make the background slightly transparent
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Transparent background for the bar itself
          elevation: 0, // Remove the default elevation since we added our own shadow
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map, color: Colors.green),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.green),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.green),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images.png'),
                radius: 12,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.green.shade200,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget buildVehicleCard(BuildContext context, String name, String distance, String time, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.green.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/electric_bike.png', // Update asset for different vehicle types
              height: 80,
              width: 120,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.battery_charging_full, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(distance, style: const TextStyle(color: Colors.green)),
                    const SizedBox(width: 16),
                    const Icon(Icons.timer, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.green.shade200,
                      ),
                      child: const Text('Book'),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '\₹$price/h',
                      style: const TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VehicleSelectionScreen(),
  ));
}
