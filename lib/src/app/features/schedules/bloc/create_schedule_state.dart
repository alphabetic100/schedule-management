part of 'create_schedule_bloc.dart';

enum CreateScheduleStatus { initial, loading, success, failure }

class CreateScheduleState extends Equatable {
  final String title;
  final String description;
  final DateTime? date;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isMeeting;
  final String? meetingLink;
  final bool launchImmediately;
  final bool isNotify;
  final int colorValue;
  final double opacity;
  final CreateScheduleStatus status;
  final String? errorMessage;
  final ScheduleModel? initialSchedule;
  final ScheduleModel? finalSchedule;

  const CreateScheduleState({
    this.title = '',
    this.description = '',
    this.date,
    this.startTime,
    this.endTime,
    this.isMeeting = false,
    this.meetingLink,
    this.launchImmediately = false,
    this.isNotify = false,
    this.colorValue = 0xFF960000,
    this.opacity = 1.0,
    this.status = CreateScheduleStatus.initial,
    this.errorMessage,
    this.initialSchedule,
    this.finalSchedule,
  });

  bool get isEdit => initialSchedule != null;

  CreateScheduleState copyWith({
    String? title,
    String? description,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    bool? isMeeting,
    String? meetingLink,
    bool? launchImmediately,
    bool? isNotify,
    int? colorValue,
    double? opacity,
    CreateScheduleStatus? status,
    String? errorMessage,
    ScheduleModel? initialSchedule,
    ScheduleModel? finalSchedule,
  }) {
    return CreateScheduleState(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isMeeting: isMeeting ?? this.isMeeting,
      meetingLink: meetingLink ?? this.meetingLink,
      launchImmediately: launchImmediately ?? this.launchImmediately,
      isNotify: isNotify ?? this.isNotify,
      colorValue: colorValue ?? this.colorValue,
      opacity: opacity ?? this.opacity,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      initialSchedule: initialSchedule ?? this.initialSchedule,
      finalSchedule: finalSchedule ?? this.finalSchedule,
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    date,
    startTime,
    endTime,
    isMeeting,
    meetingLink,
    launchImmediately,
    isNotify,
    colorValue,
    opacity,
    status,
    errorMessage,
    initialSchedule,
    finalSchedule,
  ];
}
