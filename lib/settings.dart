// lib/screens/settings.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/role.dart';
import 'providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Persona', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Adult'),
              leading: Radio<Persona>(
                value: Persona.Adult,
                groupValue: themeProvider.persona,
                onChanged: (Persona? value) {
                  themeProvider.updatePersona(value!);
                },
              ),
            ),
            ListTile(
              title: const Text('Kids'),
              leading: Radio<Persona>(
                value: Persona.Kids,
                groupValue: themeProvider.persona,
                onChanged: (Persona? value) {
                  themeProvider.updatePersona(value!);
                },
              ),
            ),
            ListTile(
              title: const Text('Teen'),
              leading: Radio<Persona>(
                value: Persona.Teen,
                groupValue: themeProvider.persona,
                onChanged: (Persona? value) {
                  themeProvider.updatePersona(value!);
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Dark Mode', style: TextStyle(fontSize: 18)),
            SwitchListTile(
              title: const Text('Enable Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                themeProvider.toggleDarkMode(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
