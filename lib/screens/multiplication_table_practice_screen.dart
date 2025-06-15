import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class MultiplicationTablePracticeScreen extends StatefulWidget {
  const MultiplicationTablePracticeScreen({super.key});

  @override
  State<MultiplicationTablePracticeScreen> createState() => _MultiplicationTablePracticeScreenState();
}

class _MultiplicationTablePracticeScreenState extends State<MultiplicationTablePracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Practice Multiplication'),
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