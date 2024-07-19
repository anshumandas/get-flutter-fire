import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  late String _verificationId;
  late TextEditingController _phoneNumberController;
  late TextEditingController _smsController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _smsController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _smsController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${_phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve the SMS code and sign in
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to your desired screen after authentication
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failed
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithPhoneNumber() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to your desired screen after authentication
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Enter phone number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Verify Phone Number'),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: _verificationId != null,
              child: Column(
                children: [
                  TextField(
                    controller: _smsController,
                    decoration: InputDecoration(labelText: 'Enter SMS Code'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _signInWithPhoneNumber,
                    child: Text('Sign In with SMS Code'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
