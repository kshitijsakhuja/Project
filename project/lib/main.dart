import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen
import 'database_helper.dart'; // Import the DatabaseHelper for SQLite

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that SQLite database is initialized before runApp()
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
