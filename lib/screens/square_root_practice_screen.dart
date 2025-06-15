import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'package:brainy_math/screens/square_root_practice_session_screen.dart';
import 'dart:math' as math;

class SquareRootPracticeScreen extends StatefulWidget {
  const SquareRootPracticeScreen({super.key});

  @override
  State<SquareRootPracticeScreen> createState() => _SquareRootPracticeScreenState();
}

class _SquareRootPracticeScreenState extends State<SquareRootPracticeScreen> {
  String _selectedRange = '1 - 10';
  bool _timerEnabled = false;
  String _selectedQuestionCount = 'All';

  final List<String> _ranges = [
    '1 - 10',
    '11 - 20',
    '21 - 30',
    '31 - 40',
    '41 - 50',
    '51 - 60'
  ];

  final List<String> _questionCounts = ['All', '5', '10', '15', '20'];

  late int _currentNumber;
  late double _correctAnswer;
  final TextEditingController _answerController = TextEditingController();
  String _feedback = '';
  bool _isCorrect = false;
  int _score = 0;
  int _totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
  }

  void _generateNewQuestion() {
    final random = math.Random();
    _currentNumber = random.nextInt(60) + 1;
    _correctAnswer = math.sqrt(_currentNumber);
    _answerController.clear();
    _feedback = '';
    _isCorrect = false;
  }

  void _checkAnswer() {
    if (_answerController.text.isEmpty) return;

    final userAnswer = double.tryParse(_answerController.text);
    if (userAnswer == null) {
      setState(() {
        _feedback = 'Please enter a valid number';
        _isCorrect = false;
      });
      return;
    }

    final difference = (userAnswer - _correctAnswer).abs();
    final isCorrect = difference < 0.01;

    setState(() {
      _isCorrect = isCorrect;
      _feedback = isCorrect
          ? 'Correct! Well done!'
          : 'Not quite. The correct answer is ${_correctAnswer.toStringAsFixed(2)}';
      if (isCorrect) _score++;
      _totalQuestions++;
    });
  }

  Widget _buildDropdownSection(String title, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _timerEnabled ? 'Enabled' : 'Disabled',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              Switch(
                value: _timerEnabled,
                onChanged: (value) {
                  setState(() {
                    _timerEnabled = value;
                  });
                },
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _startPractice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SquareRootPracticeSessionScreen(
          range: _selectedRange,
          timerEnabled: _timerEnabled,
          questionCount: _selectedQuestionCount,
        ),
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownSection(
                'Numbers',
                _selectedRange,
                _ranges,
                (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedRange = newValue;
                    });
                  }
                },
              ),
              Text(
                'Numbers: $_selectedRange',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              _buildTimeSection(),
              _buildDropdownSection(
                'Number of questions',
                _selectedQuestionCount,
                _questionCounts,
                (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedQuestionCount = newValue;
                    });
                  }
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startPractice,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
} 