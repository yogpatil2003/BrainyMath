import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class MultiplicationTableLearnScreen extends StatefulWidget {
  const MultiplicationTableLearnScreen({super.key});

  @override
  State<MultiplicationTableLearnScreen> createState() => _MultiplicationTableLearnScreenState();
}

class _MultiplicationTableLearnScreenState extends State<MultiplicationTableLearnScreen> {
  int _selectedNumber = 2;

  List<Widget> _buildTableButtons() {
    List<Widget> buttons = [];
    for (int i = 2; i <= 31; i++) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedNumber = i;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedNumber == i 
                  ? AppTheme.primaryColor 
                  : AppTheme.primaryColor.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(60, 40),
            ),
            child: Text(
              i.toString(),
              style: const TextStyle(
                fontSize: 20,
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

  List<Widget> _buildMultiplicationTable() {
    List<Widget> table = [];
    for (int i = 1; i <= 10; i++) {
      table.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_selectedNumber',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Text(
                '×',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Text(
                '$i',
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
                '${_selectedNumber * i}',
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
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Multiplication Tables'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildMultiplicationTable(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildTableButtons(),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 