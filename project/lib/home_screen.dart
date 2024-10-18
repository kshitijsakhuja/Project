import 'package:flutter/material.dart';
import 'map_page.dart'; // Import the MapWidget
import 'profile_screen.dart';
import 'book_screen.dart';

class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({super.key});

  @override
  _VehicleSelectionScreenState createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int _selectedIndex = 0;
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dropLocationController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      // Navigate to ProfilePage when avatar is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  void _showSOSDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside the dialog
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop(true); // Close the dialog after 5 seconds
        });

        return AlertDialog(
          title: const Text('SOS Alert'),
          content: const Text('You will be receiving a call in 5 seconds.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Manually close the dialog
              },
            ),
          ],
        );
      },
    );
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: buildSearchBox(), // Add the search box widget here
        ),
      ),
      body: Stack(
        children: [
          // Map Section
          const Positioned.fill(
            child: MapPage(), // Reusable Google Map Widget
          ),
          // DraggableScrollableSheet for the Vehicle Section
          DraggableScrollableSheet(
            initialChildSize: 0.4, // Initial size (percentage of screen)
            minChildSize: 0.3,     // Minimum size (percentage of screen)
            maxChildSize: 0.8,     // Maximum size (percentage of screen)
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Ensure it has a background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero, // Remove extra spacing
                  controller: scrollController,
                  children: [
                    buildVehicleCard(context, 'Road Bike', '300 km', '5 min', '18'),
                    buildVehicleCard(context, 'Mountain Bike', '150 km', '9 min', '27'),
                    buildVehicleCard(context, 'Hybrid Bike', '220 km', '7 min', '35'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: _showSOSDialog,
        child: const Icon(Icons.warning),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        elevation: 0, // Remove the box shadow effect
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.green),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0; // Navigate to the home section
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Search Box Widget based on the image provided
  Widget buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // Request focus on tap
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            // Pickup Location TextField
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter pickup location',
                  hintStyle: TextStyle(color: Colors.white70),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(color: Colors.white),
                onTap: () {
                  if (_locationController.text.isEmpty) {
                    _locationController.clear();
                  }
                },
              ),
            ),
            const SizedBox(height: 16), // Add space between the fields
            // Drop-off Location TextField
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _dropLocationController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter drop-off location',
                  hintStyle: TextStyle(color: Colors.white70),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(color: Colors.white),
                onTap: () {
                  if (_dropLocationController.text.isEmpty) {
                    _dropLocationController.clear();
                  }
                },
              ),
            ),
          ],
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
                      onPressed: () {
                        // Navigate to BookPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QRScannerPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Book Now'),
                    ),
                    const SizedBox(width: 10),
                    Text('₹$price/hr', style: const TextStyle(color: Colors.green)),
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