import 'package:flutter/material.dart';

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
      home: const PaymentMethodScreen(),
    );
  }
}

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white, // Changed to white background
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your payment option:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Text in black for readability
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPaymentOption(
                    context,
                    icon: Icons.credit_card,
                    title: 'Credit / Debit Card',
                    subtitle: 'Visa, MasterCard, American Express',
                    onTap: () {
                      // Add action for Credit/Debit card
                      _showPaymentConfirmation(context, 'Credit / Debit Card');
                    },
                  ),
                  _buildPaymentOption(
                    context,
                    icon: Icons.account_balance_wallet,
                    title: 'UPI Payment',
                    subtitle: 'Google Pay, PhonePe, BHIM, PayTM UPI',
                    onTap: () {
                      // Add action for UPI payment
                      _showPaymentConfirmation(context, 'UPI Payment');
                    },
                  ),
                  _buildPaymentOption(
                    context,
                    icon: Icons.account_balance,
                    title: 'Net Banking',
                    subtitle: 'HDFC, SBI, ICICI, Axis Bank, and more',
                    onTap: () {
                      // Add action for Net Banking
                      _showPaymentConfirmation(context, 'Net Banking');
                    },
                  ),
                  _buildPaymentOption(
                    context,
                    icon: Icons.wallet_giftcard,
                    title: 'Wallets',
                    subtitle: 'PayTM, MobiKwik, Freecharge',
                    onTap: () {
                      // Add action for Wallet payment
                      _showPaymentConfirmation(context, 'Wallets');
                    },
                  ),
                  _buildPaymentOption(
                    context,
                    icon: Icons.money,
                    title: 'Cash on Delivery',
                    subtitle: 'Pay with cash when delivered',
                    onTap: () {
                      // Add action for Cash on Delivery
                      _showPaymentConfirmation(context, 'Cash on Delivery');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building each payment option tile
  Widget _buildPaymentOption(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // White container background
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.greenAccent), // Icon with style
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Black text for readability
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54, // Subtitle in lighter black
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
          ],
        ),
      ),
    );
  }

  // Show confirmation message on tapping a payment option
  void _showPaymentConfirmation(BuildContext context, String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Method Selected'),
          content: Text('You have selected $paymentMethod.'),
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
}
