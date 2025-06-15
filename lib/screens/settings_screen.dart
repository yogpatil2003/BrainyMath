import 'package:flutter/material.dart';
import 'package:brainy_math/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isSoundEnabled = true;
  bool _isVibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionTitle('Appearance'),
            _buildSwitchTile(
              'Dark Mode',
              _isDarkMode,
              (value) {
                setState(() {
                  _isDarkMode = value;
                });
                // TODO: Implement dark mode
              },
            ),
            const Divider(),
            _buildSectionTitle('Sound & Vibration'),
            _buildSwitchTile(
              'Sound',
              _isSoundEnabled,
              (value) {
                setState(() {
                  _isSoundEnabled = value;
                });
                // TODO: Implement sound settings
              },
            ),
            _buildSwitchTile(
              'Vibration',
              _isVibrationEnabled,
              (value) {
                setState(() {
                  _isVibrationEnabled = value;
                });
                // TODO: Implement vibration settings
              },
            ),
            const Divider(),
            _buildSectionTitle('Account'),
            _buildListTile(
              'Profile',
              Icons.person,
              () {
                // TODO: Navigate to profile screen
              },
            ),
            _buildListTile(
              'Logout',
              Icons.logout,
              () async {
                // Reset login state
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                await prefs.remove('userEmail');
                
                // Navigate to login screen
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.primaryColor,
    );
  }

  Widget _buildListTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 