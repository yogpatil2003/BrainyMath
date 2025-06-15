import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'dart:math' as math;

class ExponentsLearnScreen extends StatefulWidget {
  const ExponentsLearnScreen({super.key});

  @override
  State<ExponentsLearnScreen> createState() => _ExponentsLearnScreenState();
}

class _ExponentsLearnScreenState extends State<ExponentsLearnScreen> {
  int _selectedPower = 2;

  List<Widget> _buildPowerButtons() {
    List<Widget> buttons = [];
    for (int i = 2; i <= 4; i++) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPower = i;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedPower == i 
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

  int _calculatePower(int base, int exponent) {
    return math.pow(base, exponent).toInt();
  }

  List<Widget> _buildExponentsTable() {
    List<Widget> table = [];
    for (int i = 1; i <= 20; i++) {
      table.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$i',
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -10),
                child: Text(
                  '$_selectedPower',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
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
                '${_calculatePower(i, _selectedPower)}',
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
        title: const Text('Exponents'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: _buildExponentsTable(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPowerButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 