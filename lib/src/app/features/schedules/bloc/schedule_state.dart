part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  final DateTime selectedDate;
  final List<ScheduleModel> schedules;
  final Map<DateTime, List<ScheduleModel>> events;

  const ScheduleState({
    required this.selectedDate,
    this.schedules = const [],
    this.events = const {},
  });

  ScheduleState copyWith({
    DateTime? selectedDate,
    List<ScheduleModel>? schedules,
    Map<DateTime, List<ScheduleModel>>? events,
  }) {
    return ScheduleState(
      selectedDate: selectedDate ?? this.selectedDate,
      schedules: schedules ?? this.schedules,
      events: events ?? this.events,
    );
  }

  @override
  List<Object> get props => [selectedDate, schedules, events];
}
