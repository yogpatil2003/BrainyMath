import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('BrainyMath'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to BrainyMath!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose a math operation to practice:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildOperationButton(
                      context,
                      'Addition',
                      Icons.add,
                      () {
                        Navigator.pushNamed(context, '/addition');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Subtraction',
                      Icons.remove,
                      () {
                        Navigator.pushNamed(context, '/subtraction');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Multiplication',
                      Icons.close,
                      () {
                        Navigator.pushNamed(context, '/multiplication');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Division',
                      Icons.percent,
                      () {
                        Navigator.pushNamed(context, '/division');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Multiplication Tables',
                      Icons.table_chart,
                      () {
                        Navigator.pushNamed(context, '/multiplication-table');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Square Root',
                      Icons.functions,
                      () {
                        Navigator.pushNamed(context, '/square-root');
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildOperationButton(
                      context,
                      'Exponents',
                      Icons.superscript,
                      () {
                        Navigator.pushNamed(context, '/exponents');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperationButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
} 