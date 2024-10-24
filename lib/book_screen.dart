import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isQrScanned = false;
  String qrCode = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _navigateToQRScanner(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerPage(),
      ),
    );

    if (result != null) {
      _showBookingDialog(context, result);
    }
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
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isQrScanned = true;
                  this.qrCode = qrCode;
                });
                _showSuccessDialog(context); // Show success dialog
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
          content: const Text('Your ZoopE is ready to ride!'),
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
      appBar: AppBar(
        title: const Text('Book Ride'),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isQrScanned) ...[
              Text(
                'Ready to Book your Ride?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.greenAccent.shade700,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: Colors.greenAccent.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _navigateToQRScanner(context);
                },
                icon: const Icon(Icons.qr_code_scanner, size: 24),
                label: const Text('Scan QR to Book', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.greenAccent.shade700,
              ),
            ],
            if (isQrScanned) ...[
              Text(
                'QR Code Scanned!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.greenAccent.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'QR Code: $qrCode',
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: (QRViewController qrController) {
              controller = qrController;
              controller.scannedDataStream.listen((scanData) {
                Navigator.pop(context, scanData.code); // Return the scanned data
              });
            },
          ),
          // Display the PNG indicating dimensions
          Positioned(
            bottom: 120,
            child: Image.asset(
              'assets/qr_dimensions.png', // Ensure to add this PNG asset to your project
              width: 500, // Adjust the width to make it larger
              height: 500, // Adjust the height to make it larger
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.greenAccent.shade700,
              ),
              onPressed: () {
                Navigator.pop(context); // Exit without scanning
              },
              child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
