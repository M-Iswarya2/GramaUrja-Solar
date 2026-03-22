import 'package:flutter/material.dart';
import '../services/ml_service.dart';
 // Make sure ml_service.dart is in the same folder

class SolarRecommendScreen extends StatefulWidget {
  const SolarRecommendScreen({super.key});

  @override
  State<SolarRecommendScreen> createState() => _SolarRecommendScreenState();
}

class _SolarRecommendScreenState extends State<SolarRecommendScreen> {
  final TextEditingController usageController = TextEditingController();
  final MLService mlService = MLService();

  String result = '';

  void recommend() {
    double usage = double.tryParse(usageController.text) ?? 0;
    String prediction = mlService.predictSolarSystem(usage);

    setState(() {
      result = prediction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solar Panel Suggestion"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your daily electricity usage (in kWh):",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: usageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "e.g. 3.5",
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.bolt),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: recommend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  "Get Recommendation",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
