import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const AboutUsScreen(),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildMissionSection(),
            _buildTeamSection(),
            _buildValuesSection(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Header with a creative background image
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/about_us_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
          child: const Text(
            'Who We Are',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Our Mission Section
  Widget _buildMissionSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'At Our Company, we are driven by the mission to make life simpler, smarter, and more connected through innovative solutions and customer-centric services.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Meet the Team Section
  Widget _buildTeamSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meet the Team',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We are a diverse group of innovators, designers, and engineers united by our passion for delivering outstanding products and experiences.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Core Values Section with Icons
  Widget _buildValuesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Values',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildValueItem(
                icon: Icons.lightbulb_outline,
                title: 'Innovation',
                description: 'We embrace creativity and forward-thinking.',
              ),
              _buildValueItem(
                icon: Icons.people_outline,
                title: 'Collaboration',
                description: 'Together, we achieve more.',
              ),
              _buildValueItem(
                icon: Icons.shield,
                title: 'Integrity',
                description: 'We value honesty and transparency.',
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Individual Value Card
  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.orangeAccent),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Footer with Contact Info and Social Links
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connect with Us',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.email, color: Colors.black54),
              SizedBox(width: 10),
              Text(
                'contact@ourcompany.com',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.phone, color: Colors.black54),
              SizedBox(width: 10),
              Text(
                '+1 234 567 890',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  // Add Facebook URL action
                },
                icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  // Add Twitter URL action
                },
                icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
              ),
              IconButton(
                onPressed: () {
                  // Add LinkedIn URL action
                },
                icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
