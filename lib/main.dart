import 'package:flutter/material.dart';
import 'Screens/welcome_screen.dart'; // یہ ہماری ویلکم سکرین کو جوڑ رہا ہے

void main() {
  runApp(const FaizanHolisticCareApp());
}

class FaizanHolisticCareApp extends StatelessWidget {
  const FaizanHolisticCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faizan Holistic Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00796B)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // ایپ شروع ہوتے ہی سیدھا WelcomeScreen والے صفحے پر جائے گی
      home: const WelcomeScreen(), 
    );
  }
}