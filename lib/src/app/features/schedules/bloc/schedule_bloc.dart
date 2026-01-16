import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleState(selectedDate: DateTime.now())) {
    on<ScheduleSelectedDateChanged>(_onSelectedDateChanged);

    add(ScheduleSelectedDateChanged(DateTime.now()));
  }

  void _onSelectedDateChanged(
    ScheduleSelectedDateChanged event,
    Emitter<ScheduleState> emit,
  ) {
    final schedules = getDummySchedules(event.selectedDate);
    emit(
      state.copyWith(selectedDate: event.selectedDate, schedules: schedules),
    );
  }

  static List<ScheduleModel> getDummySchedules(DateTime date) {
    // Dummy logic:
    // Even days have 2 schedules.
    // Odd days (except 5th, 15th, 25th) have 0 schedules.
    // Days multiple of 5 have 1 schedule.

    final List<ScheduleModel> dummyList = [];

    if (date.day % 2 == 0) {
      dummyList.add(
        ScheduleModel(
          id: '1',
          title: 'Team Meeting',
          description: 'Weekly team sync up to discuss project progress.',
          date: date,
          startTime: DateTime(date.year, date.month, date.day, 10, 0),
          endTime: DateTime(date.year, date.month, date.day, 11, 0),
          isMeeting: true,
          meetingLink: 'https://meet.google.com/abc-defg-hij',
        ),
      );
      dummyList.add(
        ScheduleModel(
          id: '2',
          title: 'Code Review',
          description: 'Review the new Pull Request for the Auth feature.',
          date: date,
          startTime: DateTime(date.year, date.month, date.day, 14, 0),
          endTime: DateTime(date.year, date.month, date.day, 15, 30),
          isDone: true,
        ),
      );
    } else if (date.day % 5 == 0) {
      dummyList.add(
        ScheduleModel(
          id: '3',
          title: 'Client Call',
          description: 'Discuss requirements for the next phase.',
          date: date,
          startTime: DateTime(date.year, date.month, date.day, 16, 0),
          endTime: DateTime(date.year, date.month, date.day, 17, 0),
          isMeeting: true,
          meetingLink: 'https://zoom.us/j/123456789',
          lauchImmediately: true,
        ),
      );
    }

    return dummyList;
  }
}
