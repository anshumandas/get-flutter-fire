// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';

class LoginWidgets {
  static Widget headerBuilder(context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }

  static Widget footerBuilder(myWidget) {
    return Column(
      children: [
        myWidget,
        const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ))
      ],
    );
  }

  static Widget sideBuilder(context, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }
}
