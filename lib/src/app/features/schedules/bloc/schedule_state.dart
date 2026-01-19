part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  final DateTime selectedDate;
  final List<ScheduleModel> schedules;
  final Map<DateTime, List<ScheduleModel>> events;
  final bool isLoading;

  const ScheduleState({
    required this.selectedDate,
    this.schedules = const [],
    this.events = const {},
    this.isLoading = false,
  });

  ScheduleState copyWith({
    DateTime? selectedDate,
    List<ScheduleModel>? schedules,
    Map<DateTime, List<ScheduleModel>>? events,
    bool? isLoading,
  }) {
    return ScheduleState(
      selectedDate: selectedDate ?? this.selectedDate,
      schedules: schedules ?? this.schedules,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [selectedDate, schedules, events, isLoading];
}
