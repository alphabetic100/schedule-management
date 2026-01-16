import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/extensions/app_size.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/image_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class EmptyScheduleWidget extends StatelessWidget {
  const EmptyScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImagePath.emtpySchedule, height: context.height * 0.25),
        Text(
          'No Schedules Yet!',
          style: context.bodyLarge.copyWith(color: AppColors.primaryTextColor),
        ),
      ],
    );
  }
}
