import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/theme/theme.dart';

import 'general_bindings.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: StreakzyTheme.lightTheme,
      darkTheme: StreakzyTheme.darkTheme,
        initialBinding: GeneralBindings(),
        debugShowCheckedModeBanner: false,
      home: const Scaffold(backgroundColor: SColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white,),),),
    );
  }

}