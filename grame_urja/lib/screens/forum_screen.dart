import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final List<String> messages = [];
  final TextEditingController controller = TextEditingController();

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Forum")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, index) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask a question or share a tip...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
