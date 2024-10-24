import 'package:flutter/material.dart';
import 'book_screen.dart'; // Import your QR Scanner or booking screen

class BikeDetailsPage extends StatelessWidget {
  final String bikeName;
  final String distance;
  final String time;
  final String price;

  const BikeDetailsPage({
    super.key,
    required this.bikeName,
    required this.distance,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bikeName),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background gradient
            Container(
              height: 350,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Bike Image
                  Center(
                    child: Hero(
                      tag: bikeName,
                      child: Image.asset(
                        'assets/icons/electric_bike.png',
                        height: 200,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bike Name with icon
                  Row(
                    children: [
                      const Icon(Icons.directions_bike, color: Colors.white, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        bikeName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Card for key specifications
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Key Specifications',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          _buildSpecificationRow(Icons.bolt, 'Electric Motor: 250W'),
                          _buildSpecificationRow(Icons.speed, 'Top Speed: 25 km/h'),
                          _buildSpecificationRow(Icons.battery_charging_full, 'Battery Life: Up to 60 km per charge'),
                          _buildSpecificationRow(Icons.access_time, 'Charging Time: 4 hours'),
                        ],
                      ),
                    ),
                  ),

                  // Travel Details Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Travel Details',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text('Distance to destination: $distance', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Text('Estimated travel time: $time', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Text(
                            'Price: ₹$price',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Section
                  const Text(
                    'Why Choose This Bike?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The $bikeName offers a perfect blend of comfort and performance. Whether you\'re commuting '
                        'to work or enjoying a leisure ride, this bike ensures a smooth, hassle-free experience. Its powerful electric motor '
                        'takes the strain out of pedaling, while the durable battery ensures you won’t run out of power during your ride. '
                        'It’s a smart, eco-friendly choice for your next adventure!',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),

                  // Book Now Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to QR Scanner Page or Book Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BookingPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build specification rows
  Widget _buildSpecificationRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
