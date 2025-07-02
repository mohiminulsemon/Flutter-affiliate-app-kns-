import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0f2d),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c1c3c),
        title: Row(
          children: [
            Image.asset('assets/images/app_logo.png', height: 36),
            const SizedBox(width: 8),
            const Text('KNSbuy', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie animation
              Lottie.asset(
                'assets/animations/work_in_progress.json', // Make sure to add this file
                height: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                "We're almost ready!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Thank you for being here with us. Our team is working hard to bring you the best  experience through KNSbuy.\nStay tuned for awesome updates!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
