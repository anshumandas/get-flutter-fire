import 'package:flutter/material.dart';

// Use a placeholder class for non-web platforms
class Captcha extends StatelessWidget {
  final Function(String) callback;

  Captcha(this.callback);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("CAPTCHA is not available on this platform"),
    );
  }
}
