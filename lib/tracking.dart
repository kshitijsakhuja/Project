import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CycleStatisticsScreen(),
    );
  }
}

class CycleStatisticsScreen extends StatelessWidget {
  const CycleStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cycle Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Your Cycle Overview',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Cycle Statistics Cards with progress indicators
              buildStatisticCard('Cycle Length', '29 days', Colors.purple, 1.0),
              const SizedBox(height: 16),
              buildStatisticCard('Cycle Variation', '8 days', Colors.grey, 8 / 29),
              const SizedBox(height: 16),
              buildStatisticCard('Period Length', '4 days', Colors.pink, 4 / 29),
              const SizedBox(height: 32),

              // Period Flow Header
              const Text(
                'Period Flow',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildPeriodFlowChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatisticCard(String title, String value, Color color, double progress) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(0.1),
              strokeWidth: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPeriodFlowChart() {
    final List<String> dates = ['20 May', '19 Jul', '3 Aug', '18 Aug'];
    final List<List<int>> flowData = [
      [2, 0, 1, 2, 3, 1],
      [3, 0, 1, 2, 1, 2],
      [0, 2, 3, 1, 0, 0],
      [0, 3, 2, 0, 0, 1],
    ];

    return Column(
      children: List.generate(dates.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  dates[index],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: List.generate(6, (i) {
                  return Container(
                    width: 30,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    color: getColor(flowData[index][i]),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Color getColor(int value) {
    switch (value) {
      case 0:
        return Colors.pink[100]!;
      case 1:
        return Colors.pink[300]!;
      case 2:
        return Colors.pink[500]!;
      case 3:
        return Colors.pink[700]!;
      default:
        return Colors.transparent;
    }
  }
}
