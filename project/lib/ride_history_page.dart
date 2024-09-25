import 'package:flutter/material.dart';

void main() {
  runApp(const RideHistoryApp());
}

class RideHistoryApp extends StatelessWidget {
  const RideHistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RideHistoryPage(),
    );
  }
}

class RideHistoryPage extends StatelessWidget {
  final List<Ride> rides = [
    Ride('Road Bike', '24 Sept 2024', '10:30 AM', '1h 15m', 120, Icons.directions_bike, Colors.lightBlue),
    Ride('Electric Bike', '23 Sept 2024', '2:00 PM', '45m', 75, Icons.electric_bike, Colors.green),
    Ride('Hybrid Bike', '22 Sept 2024', '11:00 AM', '30m', 50, Icons.pedal_bike, Colors.orange),
  ];

  RideHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search functionality
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHistory,
        child: ListView.builder(
          itemCount: rides.length,
          itemBuilder: (context, index) {
            return _buildRideCard(context, rides[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action, e.g. filter rides
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  Future<void> _refreshHistory() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Widget _buildRideCard(BuildContext context, Ride ride) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to detailed view
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RideDetailPage(ride: ride),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: ListTile(
            leading: Icon(
              ride.icon,
              size: 40,
              color: ride.color,
            ),
            title: Text(
              ride.cycleType,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${ride.date}, ${ride.time}'),
                Text('Duration: ${ride.duration}'),
                Text('Cost: ₹${ride.cost.toString()}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RideDetailPage extends StatelessWidget {
  final Ride ride;

  const RideDetailPage({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ride.cycleType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${ride.date}', style: const TextStyle(fontSize: 24)),
            Text('Time: ${ride.time}', style: const TextStyle(fontSize: 24)),
            Text('Duration: ${ride.duration}', style: const TextStyle(fontSize: 24)),
            Text('Cost: ₹${ride.cost.toString()}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(
              'Thank you for choosing ${ride.cycleType}!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add more details or features here
          ],
        ),
      ),
    );
  }
}

class Ride {
  final String cycleType;
  final String date;
  final String time;
  final String duration;
  final int cost;
  final IconData icon;
  final Color color;

  Ride(this.cycleType, this.date, this.time, this.duration, this.cost, this.icon, this.color);
}