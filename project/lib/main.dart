import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen
import 'firebase_options.dart'; // Import Firebase options
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that Firebase is initialized before runApp()

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZoopE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Use the splash screen
    );
  }
}
