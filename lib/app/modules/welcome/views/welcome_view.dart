import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/Shopping Master.png',
                width: 400,
                height: 400,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.LOGIN),
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  await AuthService.to.signInAnonymously();
                  Get.offAllNamed(Routes.HOME);
                },
                child: Text('Continue as Guest'),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
