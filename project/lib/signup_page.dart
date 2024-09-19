import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import the LoginScreen

void main() {
  runApp(const SignUpScreen());
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login / Sign Up Tabs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to LoginScreen with pushReplacement
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity, // Full width
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Sign up with your email and phone number',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        // Email Input Field
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Add a basic email validation pattern
                            final emailPattern =
                                r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$';
                            final isValidEmail = RegExp(emailPattern)
                                .hasMatch(value);
                            if (!isValidEmail) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            // Country Code Dropdown
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                value: selectedCountryCode,
                                items: <String>['+91', '+1', '+44', '+61']
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCountryCode = newValue;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Phone Number Field
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: "Phone number",
                                  border: UnderlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  // Add basic phone number validation
                                  if (value.length < 10) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Spacer pushes the button to the bottom
                        const Spacer(),

                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 40.0),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Handle successful form submission
                                // You can use the emailController and phoneController values here
                                final email = emailController.text;
                                final phone = phoneController.text;
                                print(
                                    "Email: $email, Phone: $selectedCountryCode$phone");
                                // Proceed with sign-up logic
                              }
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Spacing under the button
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
