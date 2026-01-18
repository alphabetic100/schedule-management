import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
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
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          buildWhen:
              (previous, current) =>
                  previous.selectedDate != current.selectedDate,
          builder: (context, state) {
            return TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: state.selectedDate,
              currentDay: DateTime.now(),
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
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                defaultDecoration: BoxDecoration(shape: BoxShape.rectangle),
                weekendDecoration: BoxDecoration(shape: BoxShape.rectangle),
                outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
                disabledDecoration: BoxDecoration(shape: BoxShape.rectangle),
                holidayDecoration: BoxDecoration(shape: BoxShape.rectangle),
                rangeStartDecoration: BoxDecoration(shape: BoxShape.rectangle),
                rangeEndDecoration: BoxDecoration(shape: BoxShape.rectangle),
                withinRangeDecoration: BoxDecoration(shape: BoxShape.rectangle),
                rangeHighlightColor: Colors.transparent,
                defaultTextStyle: context.bodySmall.copyWith(
                  color: Colors.black,
                ),
                weekendTextStyle: context.bodySmall.copyWith(
                  color: Colors.black,
                ),
                outsideTextStyle: context.bodySmall.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
                cellMargin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                markersMaxCount: 3,
                markerDecoration: BoxDecoration(
                  // is selected day will be white
                  color: AppColors.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                markerSize: 5,
                markerMargin: const EdgeInsets.only(left: 1, right: 1, top: 6),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(day, state.selectedDate);
              },
              onDaySelected: (selectedDay, focusedDay) {
                context.read<ScheduleBloc>().add(
                  ScheduleSelectedDateChanged(selectedDay),
                );
              },
              eventLoader: (day) {
                return ScheduleBloc.getDummySchedules(day);
              },
            );
          },
        ),
      ),
    );
  }
}
