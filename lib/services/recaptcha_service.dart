import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../.buildConfig.dart';
import '../app/modules/login/controllers/login_controller.dart';

class RecaptchaService extends GetxService {
  static RecaptchaService get to => Get.find();
  final LoginController loginController = Get.put(LoginController());

  Future<void> isNotABot(String action) async {
    final token = await GRecaptchaV3.execute(action);
    final response = await _getVerificationResponse(token!);
    final isNotRobot = response['score'] >= 0.5;

    if (isNotRobot) {
      loginController.robot = false;
    } else {
      loginController.robot = true;
    }

    // return isNotRobot;

    // google recaptcha v3 returns a score between 0 and 1, where 0 means bot and 1 means human.
    // We are considering anything above or equal to 0.5 as human.
  }

  Future<Map<String, dynamic>> _getVerificationResponse(String token) async {
    late http.Response response;
    try {
      response = await http.get(
        Uri.parse(
            'https://www.google.com/recaptcha/api/siteverify?secret=${BuildConfig.instance.recaptchaSecretKey}&response=$token'),
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET",
        },
      );
    } catch (e) {
      print('Error : $e');
    }

    return json.decode(response.body);
  }
}
