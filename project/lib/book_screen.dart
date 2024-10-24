import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'database_helper.dart';

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
        qrCode = scanData.code; // Get the QR code data
        _showBookingDialog(context, qrCode); // Show booking dialog
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
                setState(() {
                  isQrScanned = false; // Return to the scanner
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

                final userId = /* get logged-in user ID */;
                final distance = /* calculate distance */;
                final startLocation = /* get start location */;
                final endLocation = /* get end location */;

                // Store ride details in the database
                await DatabaseHelper().insertRental(
                  userId,
                  qrCode,
                  DateTime.now().toIso8601String(),
                  null, // End time will be set later
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
          content: const Text('Your ride has been booked!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
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
