import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class MainWalkieTalkiePage extends StatefulWidget {
  const MainWalkieTalkiePage({super.key});

  @override
  State<MainWalkieTalkiePage> createState() => _MainWalkieTalkiePageState();
}

class _MainWalkieTalkiePageState extends State<MainWalkieTalkiePage> {
  final GoogleTranslator translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  
  bool _isListening = false;
  String recognizedText = ""; 
  String translatedText = "مریض کی بات یا علامت یہاں نظر آئے گی..."; 
  String audioStatusMessage = "";
  
  String inputLanguage = 'ur'; 
  String outputLanguage = 'en'; 

  Map<String, String> languages = {
    'af': 'Afrikaans', 'sq': 'Albanian', 'am': 'Amharic', 'ar': 'Arabic', 
    'hy': 'Armenian', 'az': 'Azerbaijani', 'eu': 'Basque', 'be': 'Belarusian', 
    'bn': 'Bengali', 'bs': 'Bosnian', 'bg': 'Bulgarian', 'ca': 'Catalan', 
    'ceb': 'Cebuano', 'ny': 'Chichewa', 'zh-cn': 'Chinese (Simplified)', 
    'zh-tw': 'Chinese (Traditional)', 'co': 'Corsican', 'hr': 'Croatian', 
    'cs': 'Czech', 'da': 'Danish', 'nl': 'Dutch', 'en': 'English', 
    'eo': 'Esperanto', 'et': 'Estonian', 'tl': 'Filipino', 'fi': 'Finnish', 
    'fr': 'French', 'fy': 'Frisian', 'gl': 'Galician', 'ka': 'Georgian', 
    'de': 'German', 'el': 'Greek', 'gu': 'Gujarati', 'ht': 'Haitian Creole', 
    'ha': 'Hausa', 'haw': 'Hawaiian', 'iw': 'Hebrew', 'hi': 'Hindi', 
    'hmn': 'Hmong', 'hu': 'Hungarian', 'is': 'Icelandic', 'ig': 'Igbo', 
    'id': 'Indonesian', 'ga': 'Irish', 'it': 'Italian', 'ja': 'Japanese', 
    'jw': 'Javanese', 'kn': 'Kannada', 'kk': 'Kazakh', 'km': 'Khmer', 
    'ko': 'Korean', 'ku': 'Kurdish', 'ky': 'Kyrgyz', 'lo': 'Lao', 
    'la': 'Latin', 'lv': 'Latvian', 'lt': 'Lithuanian', 'lb': 'Luxembourgish', 
    'mk': 'Macedonian', 'mg': 'Malagasy', 'ms': 'Malay', 'ml': 'Malayalam', 
    'mt': 'Maltese', 'mi': 'Maori', 'mr': 'Marathi', 'mn': 'Mongolian', 
    'my': 'Myanmar', 'ne': 'Nepali', 'no': 'Norwegian', 'ps': 'Pashto', 
    'fa': 'Persian', 'pl': 'Polish', 'pt': 'Portuguese', 'pa': 'Punjabi', 
    'ro': 'Romanian', 'ru': 'Russian', 'sm': 'Samoan', 'gd': 'Scots Gaelic', 
    'sr': 'Serbian', 'st': 'Sesotho', 'sn': 'Shona', 'sd': 'Sindhi', 
    'si': 'Sinhala', 'sk': 'Slovak', 'sl': 'Slovenian', 'so': 'Somali', 
    'es': 'Spanish', 'su': 'Sundanese', 'sw': 'Swahili', 'sv': 'Swedish', 
    'tg': 'Tajik', 'ta': 'Tamil', 'te': 'Telugu', 'th': 'Thai', 'tr': 'Turkish', 
    'uk': 'Ukrainian', 'ur': 'Urdu', 'uz': 'Uzbek', 'vi': 'Vietnamese', 
    'cy': 'Welsh', 'xh': 'Xhosa', 'yi': 'Yiddish', 'yo': 'Yoruba', 'zu': 'Zulu'
  };

  final List<Map<String, String>> symptoms = [
    {'en': 'High Fever', 'ur': 'تیز بخار'},
    {'en': 'Severe Headache', 'ur': 'شدید سر درد'},
    {'en': 'Body Aches', 'ur': 'پورے جسم میں درد'},
    {'en': 'Fatigue / Weakness', 'ur': 'انتہائی کمزوری / تھکاوٹ'},
    {'en': 'Difficulty Breathing', 'ur': 'سانس لینے میں دشواری'},
    {'en': 'Dry Cough', 'ur': 'خشک کھانسی'},
    {'en': 'Chest Pain', 'ur': 'سینے میں درد'},
    {'en': 'Palpitations', 'ur': 'دل کی دھڑکن تیز ہونا'},
    {'en': 'Severe Stomach Pain', 'ur': 'پیٹ میں شدید درد'},
    {'en': 'Vomiting / Nausea', 'ur': 'الٹی یا متلی'},
    {'en': 'Diarrhea', 'ur': 'موک / ڈائریا'},
    {'en': 'Acidity / Heartburn', 'ur': 'معدے میں جلن'},
    {'en': 'Child: Continuous Crying', 'ur': 'بچہ: مسلسل رونا'},
    {'en': 'Child: Not Feeding', 'ur': 'بچہ: دودھ نہ پینا'},
    {'en': 'Child: High Temp', 'ur': 'بچہ: بہت تیز بخار'},
    {'en': 'Elderly: Joint Pain', 'ur': 'بزرگ: جوڑوں کا درد'},
    {'en': 'Elderly: Blurry Vision', 'ur': 'بزرگ: دھندلا نظر آنا'},
    {'en': 'Elderly: Dizziness', 'ur': 'بزرگ: چکر آنا'},
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setVolume(1.0);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          recognizedText = ""; 
          translatedText = "سن رہا ہوں... بات ختم کر کے مائیک دوبارہ دبائیں";
          audioStatusMessage = "";
        });
        
        _speech.listen(
          localeId: inputLanguage, 
          onResult: (val) {
            setState(() {
              recognizedText = val.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      _processTranslation(recognizedText);
    }
  }

  void _processTranslation(String textToTranslate) async {
    if (textToTranslate.isNotEmpty) {
      setState(() {
        translatedText = "ترجمہ ہو رہا ہے... تھوڑا انتظار کریں";
      });
      
      try {
        var translation = await translator.translate(textToTranslate, from: inputLanguage, to: outputLanguage);
        setState(() {
          translatedText = translation.text;
        });
        
        bool isLanguageAvailable = await flutterTts.isLanguageAvailable(outputLanguage) as bool;
        
        if (isLanguageAvailable) {
          setState(() { audioStatusMessage = ""; });
          await flutterTts.setLanguage(outputLanguage);
          await flutterTts.speak(translatedText);
        } else {
          setState(() { audioStatusMessage = "⚠️ آڈیو دستیاب نہیں ہے۔ صرف ترجمہ پڑھا جا سکتا ہے۔"; });
        }
      } catch (e) {
        setState(() { translatedText = "انٹرنیٹ کا مسئلہ یا ترجمہ نہیں ہو سکا۔"; });
      }
    }
  }

  void handleSymptomSelection(Map<String, String> symptom) {
    String textToTranslate = symptom[inputLanguage] ?? symptom['en']!;
    setState(() {
      recognizedText = textToTranslate; 
    });
    _processTranslation(textToTranslate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Faizan Holistic Care System", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.teal, foregroundColor: Colors.white, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: inputLanguage,
                      decoration: const InputDecoration(labelText: "مریض کی زبان:", border: InputBorder.none),
                      items: languages.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, overflow: TextOverflow.ellipsis))).toList(),
                      onChanged: (val) => setState(() => inputLanguage = val!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward, color: Colors.teal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: outputLanguage,
                      decoration: const InputDecoration(labelText: "ڈاکٹر سنے گا:", border: InputBorder.none),
                      items: languages.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, overflow: TextOverflow.ellipsis))).toList(),
                      onChanged: (val) => setState(() => outputLanguage = val!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("علامات منتخب کریں (یا نیچے مائیک استعمال کریں):", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade50, foregroundColor: Colors.teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () => handleSymptomSelection(symptoms[index]), // یہاں onTap کی جگہ onPressed کر دیا گیا ہے
                            child: Text(symptoms[index][inputLanguage] ?? symptoms[index]['en']!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.teal.shade800, borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (recognizedText.isNotEmpty)
                        Text("مریض: $recognizedText", style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      const SizedBox(height: 10),
                      Text(translatedText, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      if (audioStatusMessage.isNotEmpty)
                        Padding(padding: const EdgeInsets.only(top: 10), child: Text(audioStatusMessage, style: const TextStyle(color: Colors.orangeAccent, fontSize: 12))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton.large(
        onPressed: _listen,
        backgroundColor: _isListening ? Colors.red : Colors.teal,
        child: Icon(_isListening ? Icons.stop : Icons.mic, color: Colors.white, size: 40),
      ),
    );
  }
}