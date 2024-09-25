import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Don't forget this import
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
      // For now, this only handles the Profile tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: DropdownButton<String>(
          value: "India",
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {},
          items: <String>['Singapore', 'New York', 'London', 'India']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
              child: Stack(
                children: [
                  const MapPage(),  // Reusable Google Map Widget
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Nearby'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Cheapest'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_alt_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Vehicle Section
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  buildVehicleCard(context, 'Bike', '429 km', '6 min', '24'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildVehicleCard(BuildContext context, String name, String distance, String time, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/electric_bike.png',
              height: 80,
              width: 120,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.battery_charging_full, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(distance),
                    const SizedBox(width: 16),
                    const Icon(Icons.timer, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text('Book'),
                    ),
                    const SizedBox(width: 16),
                    Text('\₹$price/h', style: const TextStyle(fontSize: 16)),
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
