import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppTheme.accent, // Kolor wskaźnika ładowania
              strokeWidth: 6.0, // Grubość wskaźnika
            ),
            const SizedBox(height: 20),
            const Text(
              "Ładowanie...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
