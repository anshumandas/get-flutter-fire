import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'package:audioplayers/audioplayers.dart';  // Import the audioplayers package

class DashboardView extends GetView<DashboardController> {
  // Remove 'const' to avoid issues with non-constant fields
  DashboardView({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();  // Create an instance of AudioPlayer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50, // Light background color
      appBar: AppBar(
        title: const Text('Cafe App'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildFeaturedSection(),
              const SizedBox(height: 20),
              _buildCafeCards(),
              const SizedBox(height: 20),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Our Cafe!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            Text(
              'Current Time: ${controller.now.value.toLocal().toString()}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade500,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.brown),
          onPressed: () {
            _playNotificationSound();  // Play sound when icon is pressed
          },
        ),
      ],
    );
  }

  void _playNotificationSound() async {
    // Load the notification sound and play it
    await _audioPlayer.play(AssetSource('sounds/notification.mp3'));
  }

  Widget _buildFeaturedSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.orange.shade100, Colors.orange.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Specials',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
          const SizedBox(height: 10),
          _buildFeatureCard('Cappuccino', 'Rich and creamy with a smooth finish.'),
          const SizedBox(height: 10),
          _buildFeatureCard('Latte', 'Smooth and creamy, perfect for a relaxing afternoon.'),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.brown.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCafeCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildCafeCard('Cappuccino', 'Our rich and creamy cappuccino.', Icons.coffee),
        _buildCafeCard('Latte', 'A smooth and creamy latte.', Icons.coffee_maker),
        _buildCafeCard('Espresso', 'A strong and bold espresso shot.', Icons.local_cafe),
        _buildCafeCard('Pastry', 'Freshly baked pastries.', Icons.cake),
        _buildCafeCard('Cake', 'Delicious cakes for any occasion.', Icons.cake),
        _buildCafeCard('Cookies', 'Homemade cookies with a crispy edge.', Icons.cookie),
        _buildCafeCard('Muffins', 'Freshly baked muffins in various flavors.', Icons.local_cafe),
        _buildCafeCard('Brownies', 'Chewy brownies with a rich chocolate flavor.', Icons.local_pizza),
      ],
    );
  }

  Widget _buildCafeCard(String title, String description, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.orange.shade100,
              child: Center(
                child: Icon(
                  icon,  
                  size: 60,
                  color: Colors.brown.shade600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.brown.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.brown.shade900,  
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Pune Cafe street, Coffee City',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          Text(
            'Phone: +91 111-111-1111',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          Text(
            'Email: punecafeorg@ourcafe.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              
            },
            style: ElevatedButton.styleFrom(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(93, 147, 54, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
