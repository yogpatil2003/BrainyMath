import 'package:flutter/material.dart';
import 'package:brainy_math/screens/splash_screen.dart';
import 'package:brainy_math/screens/login_screen.dart';
import 'package:brainy_math/screens/register_screen.dart';
import 'package:brainy_math/screens/home_screen.dart';
import 'package:brainy_math/screens/settings_screen.dart';
import 'package:brainy_math/screens/addition_screen.dart';
import 'package:brainy_math/screens/subtraction_screen.dart';
import 'package:brainy_math/screens/multiplication_screen.dart';
import 'package:brainy_math/screens/division_screen.dart';
import 'package:brainy_math/screens/practice_screen.dart';
import 'package:brainy_math/screens/square_root_screen.dart';
import 'package:brainy_math/screens/multiplication_table_screen.dart';
import 'package:brainy_math/screens/exponents_screen.dart';
import 'package:brainy_math/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainyMath',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/addition': (context) => const AdditionScreen(),
        '/subtraction': (context) => const SubtractionScreen(),
        '/multiplication': (context) => const MultiplicationScreen(),
        '/division': (context) => const DivisionScreen(),
        '/practice': (context) => const PracticeScreen(),
        '/square-root': (context) => const SquareRootScreen(),
        '/multiplication-table': (context) => const MultiplicationTableScreen(),
        '/exponents': (context) => const ExponentsScreen(),
      },
    );
  }
}
