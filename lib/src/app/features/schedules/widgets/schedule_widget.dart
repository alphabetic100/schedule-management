import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/icon_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleWidget extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  IconPath.boxIcon,
                  height: 20,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  '${DateFormat('h:mm a').format(schedule.startTime)} - ${DateFormat('h:mm a').format(schedule.endTime)}',
                  style: context.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.title,
                  style: context.bodyLarge.copyWith(
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  schedule.description,
                  style: context.bodySmall.copyWith(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
