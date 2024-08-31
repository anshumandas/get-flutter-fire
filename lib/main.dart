import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'models/role.dart';
import 'providers/theme_provider.dart';
import 'screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadPreferences(); // Load stored preferences

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Persona Theming App',
      theme: themeProvider.currentTheme,
      home: GradientBackground(
        gradient: themeProvider.currentGradient,
        child: HomePage(),
      ),
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;

  const GradientBackground(
      {Key? key, required this.child, required this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: child,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome to the app!')),
    );
  }
}
