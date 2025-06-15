import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class DivisionScreen extends StatefulWidget {
  const DivisionScreen({super.key});

  @override
  State<DivisionScreen> createState() => _DivisionScreenState();
}

class _DivisionScreenState extends State<DivisionScreen> {
  int _numberOfQuestions = 10;
  String _difficultyLevel = 'Medium';
  final List<int> _questionOptions = [5, 10, 15, 20, 25, 30];
  final List<String> _difficultyOptions = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Division'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Configure Practice Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Customize your division practice session',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textColor.withOpacity(0.7),
                      ),
                ),
                const SizedBox(height: 48),
                _buildSettingCard(
                  'Number of Questions',
                  _numberOfQuestions.toString(),
                  _buildQuestionSelector(),
                ),
                const SizedBox(height: 24),
                _buildSettingCard(
                  'Difficulty Level',
                  _difficultyLevel,
                  _buildDifficultySelector(),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/practice',
                      arguments: {
                        'operation': 'Division',
                        'numberOfQuestions': _numberOfQuestions,
                        'difficultyLevel': _difficultyLevel,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Start Practice',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    String title,
    String value,
    Widget selector,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: $value',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 16),
            selector,
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _questionOptions.map((number) {
        return ChoiceChip(
          label: Text(number.toString()),
          selected: _numberOfQuestions == number,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _numberOfQuestions = number;
              });
            }
          },
          selectedColor: AppTheme.primaryColor,
          labelStyle: TextStyle(
            color: _numberOfQuestions == number
                ? Colors.white
                : AppTheme.textColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDifficultySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _difficultyOptions.map((difficulty) {
        return ChoiceChip(
          label: Text(difficulty),
          selected: _difficultyLevel == difficulty,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _difficultyLevel = difficulty;
              });
            }
          },
          selectedColor: AppTheme.primaryColor,
          labelStyle: TextStyle(
            color: _difficultyLevel == difficulty
                ? Colors.white
                : AppTheme.textColor,
          ),
        );
      }).toList(),
    );
  }
} 