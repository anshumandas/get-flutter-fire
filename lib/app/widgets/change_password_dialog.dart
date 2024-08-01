import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ChangePasswordDialog extends StatefulWidget {
  final User user;

  ChangePasswordDialog(this.user, {super.key});

  final _formKey = GlobalKey<FormState>();
  final _formValues = FormValues();

  @override
  State<StatefulWidget> createState() => _ChangePasswordDialogState();

  void onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _formValues.old!);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_formValues.newP!);
        Get.back(result: true);
      } catch (e) {
        _formValues.authError = "Incorrect Password";
        _formKey.currentState!.validate();
        // Get.snackbar("Error", e.toString());
      }
    }
  }

  void onReset() {
    _formKey.currentState?.reset();
  }
}

class FormValues {
  String? old;
  String? newP;
  String? authError;
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
      key: widget._formKey,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Old Password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.key),
              ),
            ),
            validator: (String? value) {
              return widget._formValues.authError ??
                  ((value != null && value.length < 8)
                      ? 'Pwd cannot be less than 8 characters'
                      : null);
            },
            onChanged: (value) {
              setState(() {
                widget._formValues.old = value;
                widget._formValues.authError = null;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "New Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (String? value) {
                return (value != null && value.length < 8)
                    ? 'Pwd cannot be less than 8 characters'
                    : (value != null && value == widget._formValues.old)
                        ? 'Pwd cannot be same as old Pwd'
                        : null;
              },
              onChanged: (value) {
                setState(() {
                  widget._formValues.newP = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.confirmation_num),
                ),
              ),
              validator: (String? value) {
                return (value != null && value != widget._formValues.newP)
                    ? 'Pwd does not match'
                    : null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: widget.onReset,
            child: const Text(
              "Reset",
            ),
          ),
        ],
      ),
    ));
  }
}
