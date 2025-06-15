import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late String _operation;
  late int _numberOfQuestions;
  late String _difficultyLevel;
  late List<Map<String, dynamic>> _questions;
  int _currentQuestionIndex = 0;
  String _userAnswer = '';
  int _correctAnswers = 0;
  bool _showTimer = true;
  Timer? _timer;
  int _seconds = 0;
  int _milliseconds = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _operation = args['operation'];
    _numberOfQuestions = args['numberOfQuestions'];
    _difficultyLevel = args['difficultyLevel'];
    _questions = _generateQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
        if (_milliseconds >= 1000) {
          _seconds++;
          _milliseconds = 0;
        }
      });
    });
  }

  List<Map<String, dynamic>> _generateQuestions() {
    final random = Random();
    final questions = <Map<String, dynamic>>[];
    int minNumber, maxNumber;

    switch (_difficultyLevel) {
      case 'Easy':
        minNumber = 1;
        maxNumber = 10;
        break;
      case 'Medium':
        minNumber = 10;
        maxNumber = 50;
        break;
      case 'Hard':
        minNumber = 50;
        maxNumber = 100;
        break;
      default:
        minNumber = 1;
        maxNumber = 10;
    }

    for (int i = 0; i < _numberOfQuestions; i++) {
      int num1 = minNumber + random.nextInt(maxNumber - minNumber + 1);
      int num2 = minNumber + random.nextInt(maxNumber - minNumber + 1);
      int answer;

      switch (_operation) {
        case 'Addition':
          answer = num1 + num2;
          break;
        case 'Subtraction':
          // Ensure num1 is greater than num2 for positive results
          if (num1 < num2) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }
          answer = num1 - num2;
          break;
        case 'Multiplication':
          answer = num1 * num2;
          break;
        case 'Division':
          // Ensure clean division
          answer = num1;
          num1 = num2 * answer;
          break;
        default:
          answer = num1 + num2;
      }

      questions.add({
        'num1': num1,
        'num2': num2,
        'answer': answer,
      });
    }

    return questions;
  }

  void _checkAnswer() {
    if (_userAnswer.isEmpty) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect = int.parse(_userAnswer) == currentQuestion['answer'];

    if (isCorrect) {
      _correctAnswers++;
    }

    if (_currentQuestionIndex < _numberOfQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
        _userAnswer = '';
      });
    } else {
      _timer?.cancel();
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Practice Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score: $_correctAnswers/$_numberOfQuestions'),
            Text('Time: ${_seconds.toString().padLeft(2, '0')}:${(_milliseconds / 10).toStringAsFixed(0).padLeft(2, '0')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to operation screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final questionText = '${currentQuestion['num1']} ${_getOperationSymbol()} ${currentQuestion['num2']}';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(_operation),
        elevation: 0,
        actions: [
          if (_showTimer)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Time ${_seconds.toString().padLeft(2, '0')}:${(_milliseconds / 10).toStringAsFixed(0).padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}/$_numberOfQuestions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    questionText,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _userAnswer.isEmpty ? '?' : _userAnswer,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildNumericKeypad(),
          ],
        ),
      ),
    );
  }

  String _getOperationSymbol() {
    switch (_operation) {
      case 'Addition':
        return '+';
      case 'Subtraction':
        return '-';
      case 'Multiplication':
        return '×';
      case 'Division':
        return '÷';
      default:
        return '+';
    }
  }

  Widget _buildNumericKeypad() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('1'),
              _buildKeypadButton('2'),
              _buildKeypadButton('3'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('4'),
              _buildKeypadButton('5'),
              _buildKeypadButton('6'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('7'),
              _buildKeypadButton('8'),
              _buildKeypadButton('9'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('⌫', onPressed: () {
                if (_userAnswer.isNotEmpty) {
                  setState(() {
                    _userAnswer = _userAnswer.substring(0, _userAnswer.length - 1);
                  });
                }
              }),
              _buildKeypadButton('0'),
              _buildKeypadButton('✓', onPressed: _checkAnswer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(String text, {VoidCallback? onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed ?? () {
          if (_userAnswer.length < 4) {
            setState(() {
              _userAnswer += text;
            });
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: text == '✓' ? AppTheme.primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: text == '✓' ? Colors.white : AppTheme.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 