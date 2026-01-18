part of 'create_schedule_bloc.dart';

abstract class CreateScheduleEvent extends Equatable {
  const CreateScheduleEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends CreateScheduleEvent {
  final String title;
  const TitleChanged(this.title);
  @override
  List<Object?> get props => [title];
}

class DescriptionChanged extends CreateScheduleEvent {
  final String description;
  const DescriptionChanged(this.description);
  @override
  List<Object?> get props => [description];
}

class DateChanged extends CreateScheduleEvent {
  final DateTime date;
  const DateChanged(this.date);
  @override
  List<Object?> get props => [date];
}

class StartTimeChanged extends CreateScheduleEvent {
  final DateTime startTime;
  const StartTimeChanged(this.startTime);
  @override
  List<Object?> get props => [startTime];
}

class EndTimeChanged extends CreateScheduleEvent {
  final DateTime endTime;
  const EndTimeChanged(this.endTime);
  @override
  List<Object?> get props => [endTime];
}

class MeetingToggled extends CreateScheduleEvent {
  final bool isMeeting;
  const MeetingToggled(this.isMeeting);
  @override
  List<Object?> get props => [isMeeting];
}

class MeetingLinkChanged extends CreateScheduleEvent {
  final String meetingLink;
  const MeetingLinkChanged(this.meetingLink);
  @override
  List<Object?> get props => [meetingLink];
}

class LaunchImmediatelyToggled extends CreateScheduleEvent {
  final bool launchImmediately;
  const LaunchImmediatelyToggled(this.launchImmediately);
  @override
  List<Object?> get props => [launchImmediately];
}

class NotifyToggled extends CreateScheduleEvent {
  final bool isNotify;
  const NotifyToggled(this.isNotify);
  @override
  List<Object?> get props => [isNotify];
}

class ColorValueChanged extends CreateScheduleEvent {
  final int colorValue;
  const ColorValueChanged(this.colorValue);
  @override
  List<Object?> get props => [colorValue];
}

class OpacityChanged extends CreateScheduleEvent {
  final double opacity;
  const OpacityChanged(this.opacity);
  @override
  List<Object?> get props => [opacity];
}

class SubmitSchedule extends CreateScheduleEvent {
  const SubmitSchedule();
}
