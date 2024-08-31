// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import '../widgets/activity_list_widget.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: ActivityListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_activity');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
