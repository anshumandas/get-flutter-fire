import 'package:flutter/material.dart';
import '../widgets/booking_form_widget.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: BookingFormWidget(),
    );
  }
}
