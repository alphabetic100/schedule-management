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
          (previous, current) =>
              previous.selectedDate != current.selectedDate ||
              previous.events != current.events,
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
                        final dayStart = DateTime(day.year, day.month, day.day);

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
                                  if (state.events[dayStart] != null)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:
                                          state.events[dayStart]!.take(3).map((
                                            schedule,
                                          ) {
                                            return Container(
                                              width: 4,
                                              height: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 1,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    isSelected
                                                        ? Colors.white
                                                        : Color(
                                                          schedule.colorValue,
                                                        ).withValues(
                                                          alpha:
                                                              schedule
                                                                  .colorOpacity,
                                                        ),
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            );
                                          }).toList(),
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
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
