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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Your Cycle Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Cycle Statistics Cards with progress indicators
            buildStatisticCard('Cycle Length', '29 days', Colors.purple, 1.0), // Full circle for 29 days
            const SizedBox(height: 16),
            buildStatisticCard('Cycle Variation', '8 days', Colors.grey, 8 / 29), // Partial circle for 8-day variation
            const SizedBox(height: 16),
            buildStatisticCard('Period Length', '4 days', Colors.pink, 4 / 29), // Partial circle for 4-day period length
            const SizedBox(height: 32),

            // Period Flow Header
            const Text(
              'Period Flow',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildPeriodFlowChart(),
          ],
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
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(0.1),
              strokeWidth: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPeriodFlowChart() {
    final List<String> dates = ['20 May', '19 Jul', '3 Aug', '18 Aug'];
    final List<List<int>> flowData = [
      [2, 0, 1, 2, 3, 1], // 20 May
      [3, 0, 1, 2, 1, 2], // 19 Jul
      [0, 2, 3, 1, 0, 0], // 3 Aug
      [0, 3, 2, 0, 0, 1], // 18 Aug
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
                  style: const TextStyle(fontSize: 16),
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
