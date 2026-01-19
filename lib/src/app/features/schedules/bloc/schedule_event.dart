part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleSelectedDateChanged extends ScheduleEvent {
  final DateTime selectedDate;

  const ScheduleSelectedDateChanged(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class ScheduleRefreshed extends ScheduleEvent {
  const ScheduleRefreshed();
}

class ScheduleDeleted extends ScheduleEvent {
  final String id;
  const ScheduleDeleted(this.id);

  @override
  List<Object> get props => [id];
}
