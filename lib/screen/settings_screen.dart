// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notifications'),
            value: true, // Replace with actual value
            onChanged: (bool value) {
              // Handle change
            },
          ),
          ListTile(
            title: Text('Privacy Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/privacy_settings');
            },
          ),
          ListTile(
            title: Text('Account Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/account_settings');
            },
          ),
        ],
      ),
    );
  }
}
