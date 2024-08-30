import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class Captcha extends StatefulWidget {
  final Function(String) callback;
  Captcha(this.callback);
  @override
  _CaptchaState createState() => _CaptchaState();
}

class _CaptchaState extends State<Captcha> {
  @override
  void initState() {
    super.initState();

    ui.platformViewRegistry.registerViewFactory(
      'recaptcha',
      (int viewId) => html.IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src = '/assets/html/recaptcha.html'
        ..style.border = 'none'
        ..id = 'recaptcha-frame',
    );

    html.window.onMessage.listen((event) {
      if (event.data['type'] == 'captchaSuccess') {
        widget.callback(event.data['token']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 300,
        width: 300,
        child: Center(
          child: HtmlElementView(
            viewType: 'recaptcha',
          ),
        ));
  }
}
