import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: VehicleSelectionScreen(),
  ));
}

class VehicleSelectionScreen extends StatelessWidget {
  const VehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZoopE'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hey Kshitij',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/user_image.png'),
                  radius: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose your vehicle',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.green, thickness: 2),
            const SizedBox(height: 16),
            const VehicleCard(
              vehicleType: 'ELECTRIC CYCLE',
              imageUrl: 'assets/icons/electric_bike.png',
            ),
            const SizedBox(height: 16),
            const VehicleCard(
              vehicleType: 'ELECTRIC SCOOTER',
              imageUrl: 'assets/icons/electric_bike.png',
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String vehicleType;
  final String imageUrl;

  const VehicleCard({super.key, required this.vehicleType, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(imageUrl, height: 150),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              vehicleType,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
