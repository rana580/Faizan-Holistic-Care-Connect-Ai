import 'package:flutter/material.dart';
import 'main_walkie_talkie_page.dart'; // فارم بھرنے کے بعد ہم اس مین پیج پر جائیں گے

class RegistrationForm extends StatefulWidget {
  final String role; // یہ بتائے گا کہ یہ مریض کا فارم ہے یا ڈاکٹر کا
  const RegistrationForm({super.key, required this.role});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // ڈیٹا محفوظ کرنے والے متغیرات
  String name = "";
  String age = "";
  String gender = "مرد"; 
  String weight = "";
  String height = "";
  String medicalHistory = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.role} کی پروفائل سیٹنگز"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // تصویر لگانے کی جگہ (Profile Picture)
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal.shade50,
                    child: const Icon(Icons.person, size: 50, color: Colors.teal),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('کیمرہ اور گیلری کا فیچر جلد آ رہا ہے!'))
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // نام
            TextFormField(
              decoration: const InputDecoration(labelText: "مکمل نام", border: OutlineInputBorder()),
              onChanged: (val) => name = val,
            ),
            const SizedBox(height: 15),

            // عمر اور جنس
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "عمر (سال)", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => age = val,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "جنس (Gender)", border: OutlineInputBorder()),
                    initialValue: gender,
                    items: ['مرد', 'عورت', 'دیگر'].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() { gender = newValue!; });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // قد اور وزن
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "وزن (kg)", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => weight = val,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "قد (مثلاً 5.8)", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => height = val,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // میڈیکل ہسٹری
            TextFormField(
              decoration: const InputDecoration(
                labelText: "میڈیکل ہسٹری / بیماریاں (تفصیل سے لکھیں)", 
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              onChanged: (val) => medicalHistory = val,
            ),
            const SizedBox(height: 30),

            // محفوظ کرنے کا بٹن
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                onPressed: () {
                  // بعد میں یہ سارا ڈیٹا Firebase Database میں جائے گا
                  // ابھی ہم ڈیٹا لے کر سیدھا لائیو کلینک پر جا رہے ہیں
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const MainWalkieTalkiePage())
                  );
                },
                child: const Text("محفوظ کریں اور آگے بڑھیں", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}