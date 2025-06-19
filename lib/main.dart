import 'package:flutter/material.dart';
import 'package:dharma_gyan/core/navigation/main_scaffold_with_bottom_nav.dart'; // Import the main scaffold
import 'package:dharma_gyan/core/theme/app_theme.dart'; // Import the app theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dharma Gyan',
      theme: AppTheme.lightTheme, // Apply the custom light theme
      home:
          const MainScaffoldWithBottomNav(), // Set MainScaffoldWithBottomNav as the home
    );
  }
}
