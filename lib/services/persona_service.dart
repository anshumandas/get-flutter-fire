import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Persona {
  final String name;
  final ThemeData themeData;
  final ThemeData darkThemeData;
  final String imageUrl;
  final Color titleColor;
  final Color textColor;
  final Color drawerColor;
  final Color drawerColor1;

  Persona({
    required this.name,
    required this.themeData,
    required this.darkThemeData,
    required this.titleColor,
    required this.textColor,
    required this.drawerColor,
    required this.drawerColor1,
    this.imageUrl = '',
  });
}

class PersonaService extends GetxService {
  final GetStorage _storage = GetStorage();
  final Rx<Persona> _selectedPersona = Persona(
    name: 'Default',
    themeData: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    darkThemeData: ThemeData.dark(),
    imageUrl: '',
    titleColor: Colors.black,
    textColor: Colors.black,
    drawerColor: const Color.fromARGB(255, 255, 255, 255),
    drawerColor1: const Color.fromARGB(255, 211, 211, 211),
  ).obs;
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  final personas = <Persona>[
    Persona(
      name: 'Default',
      themeData: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      darkThemeData: ThemeData.dark(),
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmEedEwy284CMHPcPoYXz8i9K1BkGpLyHRUo2IleoVqnEa9cVD3pgtZdu0AHVQUnTDqKY&usqp=CAUR',
      titleColor: Colors.black,
      textColor: Colors.black,
      drawerColor: const Color.fromARGB(255, 255, 255, 255),
      drawerColor1: const Color.fromARGB(255, 211, 211, 211),
    ),
    Persona(
      name: 'Kids',
      themeData: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color.fromARGB(255, 244, 157, 186),
      ),
      darkThemeData: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color.fromARGB(255, 166, 127, 168),
        brightness: Brightness.dark,
      ),
      titleColor: Colors.black,
      textColor: Colors.black,
      drawerColor: const Color.fromARGB(255, 255, 255, 255),
      drawerColor1: const Color.fromARGB(255, 255, 255, 255),
      imageUrl: 'https://static.vecteezy.com/system/resources/previews/035/867/277/original/ai-generated-cute-little-boy-with-smile-icon-illustration-avatar-of-cute-handsome-boy-cartoon-style-vector.jpg',
    ),
    Persona(
      name: 'Tech Savvy',
      themeData: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey[50],
      ),
      darkThemeData: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        brightness: Brightness.dark,
      ),
      titleColor: Colors.black,
      textColor: Colors.black,
      drawerColor: const Color.fromARGB(255, 255, 255, 255),
      drawerColor1: const Color.fromARGB(255, 255, 255, 255),
      imageUrl: 'https://img.freepik.com/premium-photo/neon-character-tech-savvy-chibi-boy-with-undercut-hairstyle-hacker-hoodie-clipart-sticker-set_655090-1193425.jpg?w=740',
    ),
    Persona(
      name: 'Nature Lover',
      themeData: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.lightGreen[50],
      ),
      darkThemeData: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.lightGreen[900],
        brightness: Brightness.dark,
      ),
      titleColor: Colors.black,
      textColor: Colors.black,
      drawerColor: const Color.fromARGB(255, 255, 255, 255),
      drawerColor1: const Color.fromARGB(255, 255, 255, 255),
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxPkSUSZlKiUTK94du4ILsKpvFMrKi32VWLOsngdc3YSIeACsE58AchtZewsNkIfM6Ge0&usqp=CAU',
    ),
  ];

  Persona get selectedPersona => _selectedPersona.value;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    loadSelectedPersona();
  }

  void loadSelectedPersona() {
    final name = _storage.read('selectedPersona') ?? 'Default';
    final isDarkMode = _storage.read('isDarkMode') ?? false;
    _selectedPersona.value = personas.firstWhere((persona) => persona.name == name);
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
    Get.changeTheme(isDarkMode ? selectedPersona.darkThemeData : selectedPersona.themeData);
  }

  void selectPersona(Persona persona) {
    _selectedPersona.value = persona;
    _storage.write('selectedPersona', persona.name);
    final isDarkMode = _storage.read('isDarkMode') ?? false;
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Get.changeThemeMode(_themeMode.value);
    Get.changeTheme(isDarkMode ? persona.darkThemeData : persona.themeData);
  }

  void toggleDarkMode(bool isDarkMode) {
    _storage.write('isDarkMode', isDarkMode);
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Get.changeThemeMode(_themeMode.value);
    Get.changeTheme(isDarkMode ? selectedPersona.darkThemeData : selectedPersona.themeData);
  }
}
