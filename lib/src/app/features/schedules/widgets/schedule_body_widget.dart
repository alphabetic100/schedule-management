import 'package:flutter/material.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/empty_schedule_widget.dart';
import 'package:schedule_management/src/core/extensions/app_size.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleBodyWidget extends StatelessWidget {
  const ScheduleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondaryTextColor.withValues(alpha: 0.3),
              border: Border(
                top: BorderSide(width: 1, color: AppColors.secondaryColor),
                left: BorderSide(width: 1, color: AppColors.secondaryColor),
                right: BorderSide(width: 1, color: AppColors.secondaryColor),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: AppColors.primaryColor,
                        size: 12,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Monday, 02 Jan, 2026',
                        style: context.bodyMedium.copyWith(
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    width: context.width,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                        left: BorderSide(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: AppColors.backgroundColor,
                    ),
                    child: Column(
                      children: [
                        // ScheduleWidget(),
                        Expanded(child: EmptyScheduleWidget()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
