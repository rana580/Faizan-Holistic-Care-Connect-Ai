import 'package:flutter/material.dart';
import 'package:translator/translator.dart'; // یہ امپورٹ ضروری ہے

class MainWalkieTalkiePage extends StatefulWidget {
  const MainWalkieTalkiePage({super.key});

  @override
  State<MainWalkieTalkiePage> createState() => _MainWalkieTalkiePageState();
}

class _MainWalkieTalkiePageState extends State<MainWalkieTalkiePage> {
  final GoogleTranslator _translator = GoogleTranslator();
  String _translatedText = "یہاں ترجمہ آئے گا...";
  
  // دنیا کی تمام بڑی زبانوں کی لسٹ (آپ اسے مزید بڑھا سکتے ہیں)
  final Map<String, String> languages = {
    'Urdu': 'ur',
    'English': 'en',
    'Chinese': 'zh-cn',
    'Arabic': 'ar',
    'Hindi': 'hi',
    'Spanish': 'es',
    // یہاں جتنی چاہیں زبانیں شامل کریں
  };

  String _selectedLanguage = 'en';

  void _translateText(String input) async {
    var translation = await _translator.translate(input, to: _selectedLanguage);
    setState(() {
      _translatedText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Walkie Talkie Translator")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedLanguage,
            items: languages.entries.map((e) => DropdownMenuItem(value: e.value, child: Text(e.key))).toList(),
            onChanged: (val) => setState(() => _selectedLanguage = val!),
          ),
          TextField(
            onSubmitted: (value) => _translateText(value),
            decoration: const InputDecoration(labelText: "اپنی بات لکھیں"),
          ),
          const SizedBox(height: 20),
          Text(_translatedText, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}