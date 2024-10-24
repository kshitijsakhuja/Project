import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'database_helper.dart';
import 'payment_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isQrScanned = false;
  String qrCode = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _navigateToQRScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCode = scanData.code!;
        _showBookingDialog(context, qrCode);
      });
    });
  }

  void _showBookingDialog(BuildContext context, String qrCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: const Text('Do you want to book this ride?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate to the previous page (home page)
                setState(() {
                  isQrScanned = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  isQrScanned = true;
                });

                const userId = 123; // Example user ID
                const distance = 12.5; // Example distance
                const startLocation = 'Start Point'; // Example start location
                const endLocation = 'End Point'; // Example end location

                // Store ride details in the database
                await DatabaseHelper().insertRental(
                  userId,
                  qrCode,
                  DateTime.now().toIso8601String(),
                  '',
                  startLocation,
                  endLocation,
                  distance,
                );

                // Show success dialog
                _showSuccessDialog(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          //content: const Text('Your ride has been booked!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentMethodScreen()), // Navigate to PaymentPage
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _navigateToQRScanner(context),
          child: const Text('Scan QR Code'),
        ),
      ),
    );
  }
}
