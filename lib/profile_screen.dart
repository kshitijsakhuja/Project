import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome
import 'home_screen.dart';
import 'tracking.dart';
import 'login_screen.dart';
import 'payment_options.dart';
import 'about_us.dart';
import 'profile_settings.dart';

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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profilePicture');
    });
  }

  Future<void> _saveProfilePicture(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicture', path);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingValue = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VehicleSelectionScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: paddingValue, vertical: screenHeight * 0.03),
            padding: EdgeInsets.all(screenWidth * 0.07),
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
                      child: CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: screenWidth * 0.14,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : const AssetImage('assets/greenglide_user.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showProfilePictureOptions(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green[800],
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Icon(
                            Icons.edit,
                            size: screenWidth * 0.05,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey Amul',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(paddingValue),
              children: [
                buildListTile(context, Icons.history, 'Ride History', const RideHistoryPage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.local_offer, 'Offers', const OffersPage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.card_giftcard, 'Refer & Earn ₹300', const ReferEarnPage(), screenWidth, isNew: true),
                const SizedBox(height: 12),
                buildListTile(context, Icons.attach_money, 'Ride Charges', const RideChargesPage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.settings, 'Settings', const SettingsPage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.location_on, 'Request a ZoopE Centre', const ZoopECentrePage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.support_agent, 'Customer Care', const CustomerCarePage(), screenWidth),
                const SizedBox(height: 12),
                buildListTile(context, Icons.track_changes, 'Cycle Statistics', const CycleStatisticsScreen(), screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProfilePictureOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Profile Picture Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _pickImageFromCamera();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Click Via Camera'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Choose From Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
      _saveProfilePicture(image.path); // Save the selected image path
    }
  }

  void _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
      _saveProfilePicture(image.path); // Save the selected image path
    }
  }

  Widget buildListTile(BuildContext context, IconData icon, String title, Widget nextPage, double screenWidth, {bool isNew = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: screenWidth * 0.04),
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
            size: screenWidth * 0.08,
            color: Colors.green[700],
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: isNew
              ? Icon(Icons.new_releases, color: Colors.red[400], size: screenWidth * 0.07)
              : Icon(Icons.arrow_forward_ios, size: screenWidth * 0.05),
        ),
      ),
    );
  }
}

// Pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.green[800],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class RideHistoryPage extends StatelessWidget {
  const RideHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rideHistory.length, // Assuming rideHistory is a list of past rides
          itemBuilder: (context, index) {
            final ride = rideHistory[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.directions_bike,
                              color: Colors.green[700],
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Ride ${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          ride['date']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Distance: ${ride['distance']} km',
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Text(
                          'Cost: ₹${ride['cost']}',
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.timer, size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              'Duration: ${ride['duration']} min',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.speed, size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              'Avg Speed: ${ride['speed']} km/h',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Mock data for ride history
final List<Map<String, String>> rideHistory = [
  {'date': '2024-08-01', 'distance': '5.2', 'cost': '50', 'duration': '12', 'speed': '25'},
  {'date': '2024-07-29', 'distance': '3.8', 'cost': '35', 'duration': '9', 'speed': '22'},
  {'date': '2024-07-25', 'distance': '6.0', 'cost': '55', 'duration': '15', 'speed': '24'},
];

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers & Discounts'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: offersList.length, // Assuming offersList is a list of available offers
          itemBuilder: (context, index) {
            final offer = offersList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Colors.green[700],
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            offer['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      offer['description']!,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              'Valid till: ${offer['validity']}',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add action for "Claim Offer" button here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Claim Offer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Mock data for offers
final List<Map<String, String>> offersList = [
  {
    'title': 'Ride More, Save More!',
    'description': 'Get a 20% discount on all rides above 5 km. Keep riding, keep saving!',
    'validity': '2024-12-31',
  },
  {
    'title': 'Refer & Earn',
    'description': 'Refer a friend and earn ₹50 for each successful referral. No limits!',
    'validity': '2025-01-15',
  },
  {
    'title': 'First Ride Free',
    'description': 'Enjoy your first ride absolutely free! Offer valid for new users only.',
    'validity': '2024-10-31',
  },
];

class ReferEarnPage extends StatelessWidget {
  const ReferEarnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer & Earn ₹300'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Title and description
            Text(
              'Refer Your Friends!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Invite your friends to use our e-cycle service and earn ₹300 for each successful referral!',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Referral code section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green[700]!,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Referral Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Implement copy to clipboard functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Referral code copied to clipboard!')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'E-CYCLE300',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(Icons.copy, color: Colors.green[700]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Share buttons
            Text(
              'Share with Friends',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildShareButton(context, FontAwesomeIcons.whatsapp, 'WhatsApp', Colors.green), // Updated
                buildShareButton(context, FontAwesomeIcons.facebook, 'Facebook', Colors.blue[700]!),
                buildShareButton(context, Icons.share, 'More', Colors.grey),
              ],
            ),
            const Spacer(),

            // Invite friends button
            ElevatedButton(
              onPressed: () {
                // Implement functionality for invite button
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Invite Friends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method for creating share buttons
  Widget buildShareButton(BuildContext context, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Add share functionality here (e.g., integrate WhatsApp/Facebook sharing)
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class RideChargesPage extends StatelessWidget {
  const RideChargesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Charges'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page header
            Text(
              'Choose Your Ride Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 20),

            // Daily Rides
            buildRideChargeCard(
              context,
              Icons.directions_bike,
              'Pay Per Ride',
              '₹10 per km',
              'Perfect for quick trips around the city.',
            ),
            const SizedBox(height: 16),

            // Weekly Pass
            buildRideChargeCard(
              context,
              Icons.access_time,
              'Weekly Pass',
              '₹300 for 7 Days',
              'Unlimited rides up to 30 km per day.',
            ),
            const SizedBox(height: 16),

            // Monthly Pass
            buildRideChargeCard(
              context,
              Icons.calendar_today,
              'Monthly Pass',
              '₹900 for 30 Days',
              'Unlimited rides up to 40 km per day.',
            ),
            const SizedBox(height: 16),

            // Terms & Conditions Section
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '*Additional charges apply for extra kilometers. Please refer to our terms and conditions.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual ride charge cards
  Widget buildRideChargeCard(
      BuildContext context,
      IconData icon,
      String title,
      String price,
      String description,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ride icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[50], // Light background for the icon
            ),
            child: Icon(
              icon,
              color: Colors.green[700],
              size: 32,
            ),
          ),
          const SizedBox(width: 16),

          // Ride details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setString('language', _selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 20),

            // Profile Settings
            buildSettingsTile(
              context,
              Icons.person,
              'Profile Settings',
              'Update your personal information',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
                );Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettingsPage())
                );
              },
            ),
            const Divider(),

            // Notifications
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.green[700],
              ),
              title: const Text('Notifications'),
              subtitle: const Text('Manage notification preferences'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                    _saveSettings(); // Save changes
                  });
                },
              ),
            ),
            const Divider(),

            // Language Selection
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.green[700],
              ),
              title: const Text('Language'),
              subtitle: Text('Select your preferred language: $_selectedLanguage'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                icon: const Icon(Icons.arrow_drop_down),
                items: <String>['English', 'Spanish', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                    _saveSettings(); // Save changes
                  });
                },
              ),
            ),
            const Divider(),

            // Payment Methods
            buildSettingsTile(
              context,
              Icons.payment,
              'Payment Methods',
              'Manage your payment options',
              onTap: () {
                // Navigate to Payment Methods Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
                );
              },
            ),

            const Divider(),

            // About Us
            buildSettingsTile(
              context,
              Icons.info,
              'About Us',
              'Learn more about our service',
              onTap: () {
                // Navigate to About Us Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              },
            ),

            const Divider(),

            // Logout Button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the LoginScreen after logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Logout button color
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual settings tile
  Widget buildSettingsTile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle, {
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.green[700],
        size: 32,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}


class ZoopECentrePage extends StatelessWidget {
  const ZoopECentrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a ZoopE Centre'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Help us set up a ZoopE hotspot in your area! Please fill out the form below.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // User Name
              buildTextField(
                label: 'Your Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              // Contact Number
              buildTextField(
                label: 'Contact Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Locality
              buildTextField(
                label: 'Locality',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),

              // Reason for Request
              buildTextField(
                label: 'Reason for Request',
                icon: Icons.comment,
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle request submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request for ZoopE Centre submitted successfully!')),
                    );
                    // Optionally navigate back or clear fields
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700], // Button color
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build text fields with icons
  Widget buildTextField({required String label, required IconData icon, int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[900]!), // Darker green on focus
        ),
      ),
    );
  }
}

class CustomerCarePage extends StatelessWidget {
  const CustomerCarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Care'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Need assistance? We are here to help!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // Inquiry Form
              buildInquiryForm(context),

              const SizedBox(height: 30),

              // Contact Options Header
              const Text(
                'Contact Us Directly:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Phone Contact
              buildContactOption(Icons.phone, 'Call Us', '+1 234 567 890', context),
              const SizedBox(height: 10),

              // Email Contact
              buildContactOption(Icons.email, 'Email Us', 'support@zoope.com', context),
              const SizedBox(height: 10),

              // FAQs Link
              buildContactOption(Icons.question_answer, 'FAQs', 'Find answers to common questions.', context),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build inquiry form
  static Widget buildInquiryForm(BuildContext context) {
    final TextEditingController inquiryController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Inquiry:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Inquiry Text Field
        TextField(
          controller: inquiryController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Type your message here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green[900]!),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Submit Button
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Show Snackbar on submit
              final inquiryText = inquiryController.text;
              if (inquiryText.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Inquiry submitted: $inquiryText'),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.green[700],
                  ),
                );
                inquiryController.clear(); // Clear the text field
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a message before submitting.'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Submit Inquiry',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Function to build contact options
  static Widget buildContactOption(IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle the action (e.g., open dialer for phone, email client for email)
        if (title == 'Call Us') {
          // Example: Call function
          // You can add your phone dialer logic here
        } else if (title == 'Email Us') {
          // Example: Email function
          // You can add your email logic here
        } else if (title == 'FAQs') {
          // Example: FAQs logic
          // You can navigate to the FAQs page
        }
      },
    );
  }
}