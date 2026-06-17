import 'package:flutter/material.dart';
import 'registration_form.dart'; // <--- اب یہ لائیو کلینک کی بجائے پہلے فارم پر بھیجے گا

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF00796B).withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.health_and_safety_rounded, size: 100, color: Color(0xFF00796B)),
              ),
              const SizedBox(height: 40),
              const Text('Faizan Holistic Care', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF004D40)), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              const Text('عالمی سطح پر صحت کی سہولیات، اب آپ کی زبان میں۔', style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5), textAlign: TextAlign.center),
              const SizedBox(height: 50),
              
              // مریض کا بٹن
              _buildRoleButton(
                context: context, title: 'میں ایک مریض ہوں', subtitle: 'اپنی زبان میں بیماری بتائیں اور علاج پائیں', icon: Icons.personal_injury_rounded, color: Colors.blue.shade700,
                onTap: () {
                  // یہ اب رجسٹریشن فارم پر جائے گا اور بتائے گا کہ مریض آیا ہے
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm(role: "مریض")));
                },
              ),
              const SizedBox(height: 20),
              
              // ڈاکٹر کا بٹن
              _buildRoleButton(
                context: context, title: 'میں ایک ڈاکٹر ہوں / ماہرِ طب', subtitle: 'عالمی مریضوں کا ان کی زبان میں علاج کریں', icon: Icons.medical_services_rounded, color: const Color(0xFF00796B),
                onTap: () {
                  // یہ اب رجسٹریشن فارم پر جائے گا اور بتائے گا کہ ڈاکٹر آیا ہے
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm(role: "ڈاکٹر")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({required BuildContext context, required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: color.withOpacity(0.3), width: 2)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 15),
          ],
        ),
      ),
    );
  }
}