import 'package:flutter/material.dart';
import 'package:schedule_management/src/app/features/home/widgets/custom_bottom_navbar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomNavbar());
  }
}
