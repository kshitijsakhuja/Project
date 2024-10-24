import 'package:flutter/material.dart';

void main() => runApp(const PaymentOptionsApp());

class PaymentOptionsApp extends StatelessWidget {
  const PaymentOptionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Options',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentOptionsScreen(),
    );
  }
}

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Cards'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Cards selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Net Banking'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Net Banking selection
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.send),
            title: const Text('Pay by any UPI'),
            children: <Widget>[
              ListTile(
                leading: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/5/57/Google_Pay_%28GPay%29_Logo.png',
                  width: 30,
                  height: 30,
                ),
                title: const Text('GPay'),
                onTap: () {
                  // Handle GPay selection
                },
              ),
              ListTile(
                leading: const Icon(Icons.more_horiz),
                title: const Text('Others'),
                onTap: () {
                  // Handle other UPI apps selection
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Wallets'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle Wallets selection
            },
          ),
        ],
      ),
    );
  }
}
