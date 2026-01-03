import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/common/widgets/custom_button.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/image_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagePath.emptyState),
          SizedBox(height: 16),
          Text(
            'No Schedules Yet!',
            style: context.bodyLarge.copyWith(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'You have no schedules at the moment. Start by adding a new schedule to stay organized!',
            style: context.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          CustomButton(label: 'Add Schedule', onPressed: () {}),
        ],
      ),
    );
  }
}
