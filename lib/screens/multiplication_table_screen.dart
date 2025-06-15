import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'package:brainy_math/screens/multiplication_table_learn_screen.dart';
import 'package:brainy_math/screens/multiplication_table_practice_screen.dart';

class MultiplicationTableScreen extends StatelessWidget {
  const MultiplicationTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Multiplication Table'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose Your Learning Path',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select whether you want to learn multiplication tables or practice them',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 48),
              _buildOptionCard(
                context,
                'Learn Multiplication Tables',
                'Master multiplication tables from 1 to 12 with detailed examples',
                Icons.school,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MultiplicationTableLearnScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildOptionCard(
                context,
                'Practice Multiplication Tables',
                'Test your knowledge with interactive practice sessions',
                Icons.edit,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MultiplicationTablePracticeScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 