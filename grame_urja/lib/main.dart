import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 🔥 REQUIRED

  await Firebase.initializeApp(); // 🔥 THIS FIXES YOUR ERROR

  runApp(const GrameUrjaApp());
}

class GrameUrjaApp extends StatelessWidget {
  const GrameUrjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grama Urja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}