part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  final DateTime selectedDate;
  final List<ScheduleModel> schedules;

  const ScheduleState({required this.selectedDate, this.schedules = const []});

  ScheduleState copyWith({
    DateTime? selectedDate,
    List<ScheduleModel>? schedules,
  }) {
    return ScheduleState(
      selectedDate: selectedDate ?? this.selectedDate,
      schedules: schedules ?? this.schedules,
    );
  }

  @override
  List<Object> get props => [selectedDate, schedules];
}
