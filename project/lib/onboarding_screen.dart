import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'login_screen.dart';
import 'signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZoopE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background_video.mp4') // Ensure this asset exists and is registered in pubspec.yaml
      ..initialize().then((_) {
        setState(() {}); // Update the UI once the video is initialized
        _controller.play();
        _controller.setLooping(true); // Loop the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make the background transparent
      body: SafeArea(
        child: Stack(
          children: [
            if (_controller.value.isInitialized) // Check if the video is initialized
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'ZoopE',
                    style: TextStyle(
                      color: Colors.white, // Ensure text is visible on the video
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.transparent, // Transparent background
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Flexible(
                    child: Text(
                      'Feel the joy,\ntake the ride\nRent a bike!',
                      style: TextStyle(
                        color: Colors.white, // Ensure text is visible
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        backgroundColor: Colors.transparent, // Transparent background
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Positioned(
              bottom: 30.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.8), // Semi-transparent green
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 6.0,
                      shadowColor: Colors.greenAccent.withOpacity(0.4), // Semi-transparent shadow
                    ),
                    onPressed: () {
                      debugPrint('Get Started button pressed.');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            backgroundColor: Colors.transparent, // Transparent background
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white, // Ensure text is visible
                          fontSize: 16.0,
                          backgroundColor: Colors.transparent, // Transparent background
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Login text tapped.');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.greenAccent, // Highlighted text color
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            backgroundColor: Colors.transparent, // Transparent background
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
