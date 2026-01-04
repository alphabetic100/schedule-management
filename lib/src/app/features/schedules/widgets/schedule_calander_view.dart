import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalanderView extends StatelessWidget {
  const ScheduleCalanderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: DateTime(2024, 1, 2),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          rowHeight: 45,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: context.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextColor,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: AppColors.primaryColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: AppColors.primaryColor,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: context.bodySmall.copyWith(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.normal,
            ),
            weekendStyle: context.bodySmall.copyWith(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            defaultTextStyle: context.bodySmall.copyWith(color: Colors.black),
            weekendTextStyle: context.bodySmall.copyWith(color: Colors.black),
            outsideTextStyle: context.bodySmall.copyWith(
              color: AppColors.secondaryTextColor,
            ),
            cellMargin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            markersMaxCount: 3,
            markerDecoration: BoxDecoration(
              // is selected day will be white
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            markerSize: 5,
            markerMargin: const EdgeInsets.only(left: 1, right: 1, top: 6),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(day, DateTime(2024, 1, 2));
          },
          eventLoader: (day) {
            // Add dots for specific days
            if (day.day == 2) return [1, 2, 3];
            if (day.day == 3) return [1, 2];
            if (day.day == 6) return [1];
            if (day.day == 8) return [1];
            if (day.day == 10) return [1, 2, 3];
            if (day.day == 13) return [1, 2];
            if (day.day == 15) return [1, 2];
            if (day.day == 17) return [1];
            if (day.day == 20) return [1, 2];
            if (day.day == 22) return [1, 2, 3];
            if (day.day == 23) return [1];
            if (day.day == 29) return [1, 2, 3];
            if (day.day == 31) return [1, 2, 3];
            return [];
          },
        ),
      ),
    );
  }
}
