import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class SquareRootLearnScreen extends StatefulWidget {
  const SquareRootLearnScreen({super.key});

  @override
  State<SquareRootLearnScreen> createState() => _SquareRootLearnScreenState();
}

class _SquareRootLearnScreenState extends State<SquareRootLearnScreen> {
  int _selectedRange = 10;

  List<Widget> _buildRangeButtons() {
    List<Widget> buttons = [];
    for (int i = 10; i <= 60; i += 10) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedRange = i;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedRange == i 
                  ? AppTheme.primaryColor 
                  : AppTheme.primaryColor.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(45, 36),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            ),
            child: Text(
              i.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  List<Widget> _getPerfectSquaresInRange(int range) {
    List<Widget> squares = [];
    int start = range == 10 ? 1 : ((range - 10) ~/ 10) * 10 + 1;
    int end = range;

    for (int i = start; i <= end; i++) {
      int square = i * i;
      squares.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '√$square',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Text(
                '=',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Text(
                '$i',
                style: TextStyle(
                  fontSize: 32,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return squares;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Square Root'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: _getPerfectSquaresInRange(_selectedRange),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildRangeButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 