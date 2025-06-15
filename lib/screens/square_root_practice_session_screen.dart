import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'dart:async';
import 'dart:math' as math;

class SquareRootPracticeSessionScreen extends StatefulWidget {
  final String range;
  final bool timerEnabled;
  final String questionCount;

  const SquareRootPracticeSessionScreen({
    super.key,
    required this.range,
    required this.timerEnabled,
    required this.questionCount,
  });

  @override
  State<SquareRootPracticeSessionScreen> createState() => _SquareRootPracticeSessionScreenState();
}

class _SquareRootPracticeSessionScreenState extends State<SquareRootPracticeSessionScreen> {
  int _currentQuestionIndex = 0;
  late int _totalQuestions;
  String _userAnswer = '';
  int _correctAnswers = 0;
  Timer? _timer;
  int _seconds = 0;
  int _milliseconds = 0;
  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  void _initializeSession() {
    final rangeParts = widget.range.split(' - ');
    final min = int.parse(rangeParts[0]);
    final max = int.parse(rangeParts[1]);
    
    if (widget.questionCount == 'All') {
      _totalQuestions = max - min + 1;
    } else {
      _totalQuestions = int.parse(widget.questionCount);
    }

    _questions = _generateQuestions(min, max);
    
    if (widget.timerEnabled) {
      _startTimer();
    }
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

  List<Map<String, dynamic>> _generateQuestions(int min, int max) {
    final random = math.Random();
    final questions = <Map<String, dynamic>>[];
    final Set<int> usedNumbers = {};

    for (int i = 0; i < _totalQuestions; i++) {
      int answer;
      do {
        answer = min + random.nextInt(max - min + 1);
      } while (usedNumbers.contains(answer));
      
      usedNumbers.add(answer);
      questions.add({
        'number': answer * answer,
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

    if (_currentQuestionIndex < _totalQuestions - 1) {
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
            Text('Score: $_correctAnswers/$_totalQuestions'),
            if (widget.timerEnabled)
              Text('Time: ${_seconds.toString().padLeft(2, '0')}:${(_milliseconds / 10).toStringAsFixed(0).padLeft(2, '0')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Done'),
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

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final questionText = '√${currentQuestion['number']}';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Square Root'),
            if (widget.timerEnabled)
              Text(
                'Time ${_seconds.toString().padLeft(2, '0')}:${(_milliseconds / 10).toStringAsFixed(0).padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}/$_totalQuestions',
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
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
} 