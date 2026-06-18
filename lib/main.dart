import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/main_walkie_talkie_page.dart';

void main() async {
  // ایپ شروع ہونے کا پیغام
  debugPrint("--- App is starting now ---");
  
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // فائر بیس کو شروع کرنے کی کوشش
    await Firebase.initializeApp();
    debugPrint("--- Firebase Initialized Successfully ---");
  } catch (e) {
    // اگر فائر بیس میں کوئی مسئلہ ہوا تو یہاں نظر آ جائے گا
    debugPrint("--- Firebase Error: $e ---");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainWalkieTalkiePage(),
    );
  }
}