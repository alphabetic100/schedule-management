import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/utils/constants/icon_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.secondaryTextColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            IconPath.homeIcon,
            width: 20,
            height: 20,
            color: currentIndex == 0
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            IconPath.calandarIcon,
            width: 20,
            height: 20,
            color: currentIndex == 1
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
          ),
          label: 'Schedules',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            IconPath.settingsIcon,
            width: 20,
            height: 20,
            color: currentIndex == 2
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
