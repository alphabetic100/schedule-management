import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/icon_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

import 'package:schedule_management/src/app/features/schedules/screens/schedule_details_screen.dart';

class ScheduleWidget extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final scheduleBloc = context.read<ScheduleBloc>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider.value(
                  value: scheduleBloc,
                  child: ScheduleDetailsScreen(schedule: schedule),
                ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: Color(
            schedule.colorValue,
          ).withValues(alpha: schedule.colorOpacity),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color(
              schedule.colorValue,
            ).withValues(alpha: schedule.colorOpacity),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
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
                    color: Color(
                      schedule.colorValue,
                    ).withValues(alpha: schedule.colorOpacity),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat('h:mm a').format(schedule.startTime)} - ${DateFormat('h:mm a').format(schedule.endTime)}',
                    style: context.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 6),
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
                  const SizedBox(height: 6),
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
      ),
    );
  }
}
