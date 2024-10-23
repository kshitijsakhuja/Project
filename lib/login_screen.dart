import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const ZoopEApp());
}

class ZoopEApp extends StatelessWidget {
  const ZoopEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ZoopE',
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers to manage the input
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login to ZoopE",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController, // Email/Phone input controller
                decoration: InputDecoration(
                  hintText: 'Enter phone number or email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController, // Password input controller
                obscureText: true, // Mask the password input
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Check if both the email/phone and password fields are empty
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter both email/phone and password.'),
                      ),
                    );
                  } else {
                    // Navigate to VehicleSelectionScreen when both inputs are valid
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VehicleSelectionScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Continue button color
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('or', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  // Action for Google Sign-in
                },
                icon: const Icon(Icons.g_translate, color: Colors.black),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  // Action for Apple Sign-in
                },
                icon: const Icon(Icons.apple, color: Colors.black),
                label: const Text(
                  'Continue with Apple',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'By proceeding, you consent to receiving calls, WhatsApp, or SMS/RCS messages, including by automated dialer, from ZoopE and its affiliates to the number provided.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Text “STOP” to 89203 to opt out.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Welcome to ZoopE!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
