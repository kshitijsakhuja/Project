import 'package:flutter/material.dart';
import 'map_page.dart'; // Import the MapWidget
import 'profile_screen.dart';
import 'bike_detail.dart';

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
      extendBodyBehindAppBar: true, // Make the body go behind the AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove shadow of the AppBar
        toolbarHeight: 120.0, // Increase the height of the AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Color(0xFF1DB954)], // Transparent to green gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Increase search box space
          child: buildSearchBox(),
        ),
      ),
      body: SafeArea( // Wrap body content in SafeArea to avoid system overlap
        child: Stack(
          children: [
            const Positioned.fill(
              child: MapPage(), // Reusable Google Map Widget
            ),
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

  // Search Box Widget without a background container
  Widget buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Larger padding
      child: GestureDetector(
        onTap: () {
          // Request focus on tap
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView( // Wrap the content in a scroll view to handle overflow
          child: Column(
            children: [
              // Pickup Location TextField with green dot
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16), // Adjust position of the dot
                    child: Icon(Icons.circle, size: 12, color: Colors.green), // Green dot
                  ),
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 2.0, // Medium border width
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Enter pickup location',
                        hintStyle: const TextStyle(color: Colors.black, fontSize: 18), // Larger text
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      ),
                      style: const TextStyle(color: Colors.black), // Corrected text color
                      onTap: () {
                        if (_locationController.text.isEmpty) {
                          _locationController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Add space between the fields
              // Drop-off Location TextField with red dot
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16), // Adjust position of the dot
                    child: Icon(Icons.circle, size: 12, color: Colors.red), // Red dot
                  ),
                  Expanded(
                    child: TextField(
                      controller: _dropLocationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 2.0, // Medium border width
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Enter drop-off location',
                        hintStyle: const TextStyle(color: Colors.black, fontSize: 18), // Larger text
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      ),
                      style: const TextStyle(color: Colors.black), // Corrected text color
                      onTap: () {
                        if (_dropLocationController.text.isEmpty) {
                          _dropLocationController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVehicleCard(BuildContext context, String name, String distance, String time, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.green.shade100,
      child: InkWell( // Make the card clickable
        onTap: () {
          // Navigate to the BikeDetailsPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BikeDetailsPage(
                bikeName: name,
                distance: distance,
                time: time,
                price: price,
              ),
            ),
          );
        },
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
                      Text('$distance remaining', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('$time away', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('\₹$price/hr', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main function should be outside the class
void main() {
  runApp(const MaterialApp(
    home: VehicleSelectionScreen(),
  ));
}
