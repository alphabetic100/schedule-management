import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';
import 'package:schedule_management/src/core/data/repositories/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleBloc({required ScheduleRepository scheduleRepository})
    : _scheduleRepository = scheduleRepository,
      super(ScheduleState(selectedDate: DateTime.now())) {
    on<ScheduleSelectedDateChanged>(_onSelectedDateChanged);
    on<ScheduleRefreshed>(_onScheduleRefreshed);

    add(ScheduleSelectedDateChanged(DateTime.now()));
  }

  Future<void> _onSelectedDateChanged(
    ScheduleSelectedDateChanged event,
    Emitter<ScheduleState> emit,
  ) async {
    final schedules = await _scheduleRepository.getSchedules(
      event.selectedDate,
    );
    final allEvents = await _scheduleRepository.getSchedulesForMonth(
      event.selectedDate,
    );

    final eventsMap = <DateTime, List<ScheduleModel>>{};
    for (var schedule in allEvents) {
      final date = DateTime(
        schedule.date.year,
        schedule.date.month,
        schedule.date.day,
      );
      if (eventsMap[date] == null) {
        eventsMap[date] = [];
      }
      eventsMap[date]!.add(schedule);
    }

    emit(
      state.copyWith(
        selectedDate: event.selectedDate,
        schedules: schedules,
        events: eventsMap,
      ),
    );
  }

  Future<void> _onScheduleRefreshed(
    ScheduleRefreshed event,
    Emitter<ScheduleState> emit,
  ) async {
    final schedules = await _scheduleRepository.getSchedules(
      state.selectedDate,
    );
    final allEvents = await _scheduleRepository.getSchedulesForMonth(
      state.selectedDate,
    );

    final eventsMap = <DateTime, List<ScheduleModel>>{};
    for (var schedule in allEvents) {
      final date = DateTime(
        schedule.date.year,
        schedule.date.month,
        schedule.date.day,
      );
      if (eventsMap[date] == null) {
        eventsMap[date] = [];
      }
      eventsMap[date]!.add(schedule);
    }

    emit(state.copyWith(schedules: schedules, events: eventsMap));
  }
}
