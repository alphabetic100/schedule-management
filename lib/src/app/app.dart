import 'package:flutter/material.dart';
import 'package:schedule_management/src/app/features/splash/screens/splash_screen.dart';
import 'package:schedule_management/src/core/utils/theme/app_theme.dart';

class SchedulerApp extends StatelessWidget {
  const SchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule Management App',
      home: SplashScreen(),
      theme: AppTheme.appTheme,
    );
  }
}
