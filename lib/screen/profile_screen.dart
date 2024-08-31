// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../widgets/profile_picture_widget.dart';
import '../widgets/user_info_form.dart';
import '../widgets/health_data_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfilePictureWidget(),
            UserInfoForm(),
            HealthDataWidget(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
