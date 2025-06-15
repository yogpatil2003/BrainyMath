import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'package:brainy_math/screens/square_root_learn_screen.dart';
import 'package:brainy_math/screens/square_root_practice_screen.dart';

class SquareRootScreen extends StatelessWidget {
  const SquareRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Square Root'),
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
                'Select whether you want to learn about square roots or practice them',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 48),
              _buildOptionCard(
                context,
                'Learn Square Roots',
                'Master square roots from 1 to 60 with detailed examples',
                Icons.school,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SquareRootLearnScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildOptionCard(
                context,
                'Practice Square Roots',
                'Test your knowledge with interactive practice sessions',
                Icons.edit,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SquareRootPracticeScreen(),
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