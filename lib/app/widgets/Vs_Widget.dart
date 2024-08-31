import 'package:flutter/material.dart';

class VsWidget extends StatelessWidget {
  final String imageUrl1;
  final String imageUrl2;
  final String label1;
  final String label2;

  VsWidget({
    required this.imageUrl1,
    required this.imageUrl2,
    required this.label1,
    required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.black, // Background color for the VS screen
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImageWithLabel(imageUrl1, label1),
              SizedBox(width: 20),
              Text(
                'VS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              _buildImageWithLabel(imageUrl2, label2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithLabel(String imageUrl, String label) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
