import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class WeekViewWidget extends StatelessWidget {
  const WeekViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen:
          (previous, current) => previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        final selectedDate = state.selectedDate;
        final weekDays = _getWeekDays(selectedDate);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  DateFormat('MMM yyyy').format(selectedDate),
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      weekDays.map((day) {
                        final isSelected = isSameDay(day, selectedDate);
                        final events = ScheduleBloc.getDummySchedules(day);
                        final hasEvents = events.isNotEmpty;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<ScheduleBloc>().add(
                                ScheduleSelectedDateChanged(day),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryTextColor
                                              .withValues(alpha: 0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat(
                                      'EEE',
                                    ).format(day).substring(0, 3),
                                    style: context.bodySmall.copyWith(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : AppColors.secondaryTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd').format(day),
                                    style: context.bodyLarge.copyWith(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : AppColors.primaryTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (hasEvents)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        events.length > 3 ? 3 : events.length,
                                        (i) => Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<DateTime> _getWeekDays(DateTime date) {
    // Optimization: Calculate start of week once
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
