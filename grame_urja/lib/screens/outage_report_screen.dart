import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OutageReportScreen extends StatefulWidget {
  const OutageReportScreen({super.key});

  @override
  State<OutageReportScreen> createState() => _OutageReportScreenState();
}

class _OutageReportScreenState extends State<OutageReportScreen> {

  // ✅ Controllers (moved outside build)
  final TextEditingController villageController = TextEditingController();
  final TextEditingController issueController = TextEditingController();

  // 🔥 Submit function with Firebase
  void _submitReport() async {
    final village = villageController.text.trim();
    final issue = issueController.text.trim();

    if (village.isEmpty || issue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all the details"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('outages').add({
        'village': village,
        'issue': issue,
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Outage reported successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      villageController.clear();
      issueController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ✅ Clean up memory
  @override
  void dispose() {
    villageController.dispose();
    issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📡 Report Power Outage"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe0c3fc), Color(0xff8ec5fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Let Us Know!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🏡 Village Input
                    TextField(
                      controller: villageController,
                      decoration: InputDecoration(
                        labelText: "Village Name",
                        prefixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ⚠️ Issue Input
                    TextField(
                      controller: issueController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Describe the Problem",
                        prefixIcon: const Icon(Icons.report),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🚀 Submit Button
                    ElevatedButton.icon(
                      onPressed: _submitReport,
                      icon: const Icon(Icons.send),
                      label: const Text("Submit Report"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}