import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/common/widgets/custom_button.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/image_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class NotificationPermissionWidget extends StatelessWidget {
  const NotificationPermissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagePath.notificationPermission),
          Text(
            'Never Miss a Schedule!',
            style: context.bodyLarge.copyWith(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Allow notifications to receive alerts before your schedules start, so nothing important slips through.',
            style: context.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 22),
          CustomButton(label: 'Enable Notifications', onPressed: () {}),
          SizedBox(height: 8),
          InkWell(
            onTap: () {},
            child: Text(
              'Maybe Later',
              style: context.bodySmall.copyWith(
                color: AppColors.secondaryTextColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
