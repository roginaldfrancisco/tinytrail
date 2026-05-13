import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Choose Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Daylight'),
              trailing: themeProvider.currentTheme == 'daylight' ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () => themeProvider.setTheme('daylight'),
            ),
            ListTile(
              leading: const Icon(Icons.nightlight_round),
              title: const Text('Starlight'),
              trailing: themeProvider.currentTheme == 'starlight' ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () => themeProvider.setTheme('starlight'),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Candy'),
              trailing: themeProvider.currentTheme == 'candy' ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () => themeProvider.setTheme('candy'),
            ),
          ],
        ),
      ),
    );
  }
}