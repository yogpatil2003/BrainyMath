import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class ExponentsPracticeScreen extends StatefulWidget {
  const ExponentsPracticeScreen({super.key});

  @override
  State<ExponentsPracticeScreen> createState() => _ExponentsPracticeScreenState();
}

class _ExponentsPracticeScreenState extends State<ExponentsPracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Practice Exponents'),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Practice screen coming soon...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
} 