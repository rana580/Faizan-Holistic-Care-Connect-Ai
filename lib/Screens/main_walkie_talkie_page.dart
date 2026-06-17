import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class MainWalkieTalkiePage extends StatefulWidget {
  const MainWalkieTalkiePage({super.key});

  @override
  State<MainWalkieTalkiePage> createState() => _MainWalkieTalkiePageState();
}

class _MainWalkieTalkiePageState extends State<MainWalkieTalkiePage> {
  // یہاں وہی پرانا ترجمے والا لاجک رہے گا جو ہم نے پہلے ٹیسٹ کیا تھا
  String currentStatus = "مائیک دبائیں";
  bool isRecording = false;
  stt.SpeechToText _speechToText = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();
  String recognizedText = "";
  String translatedText = "";
  String patientLocale = 'ur-PK';
  String patientTransCode = 'ur';
  String doctorLocale = 'en-US';
  String doctorTransCode = 'en';

  final List<Map<String, String>> availableLanguages = [
    {'name': 'اردو (Pakistan)', 'locale': 'ur-PK', 'transCode': 'ur'},
    {'name': 'English (Global)', 'locale': 'en-US', 'transCode': 'en'},
  ];

  @override
  void initState() {
    super.initState();
    _speechToText.initialize();
  }

  // (باقی تمام فنکشنز اور UI وہی ہیں جو ہم نے پہلے فائنل کیے تھے)
  // نوٹ: آپ پچھلے والے کوڈ سے اس حصے کو یہاں کاپی پیسٹ کر سکتے ہیں تاکہ وقت ضائع نہ ہو
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Clinic")),
      body: Center(child: Text("یہاں ہمارا ٹرانسلیشن انجن چلے گا")),
    );
  }
}