import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final bool isDone;
  final bool isMeeting;
  final String? meetingLink;
  final bool lauchImmediately;
  final bool isNotify;

  const ScheduleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
    this.isMeeting = false,
    this.meetingLink,
    this.lauchImmediately = false,
    this.isNotify = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    startTime,
    endTime,
    isDone,
    isMeeting,
    meetingLink,
    lauchImmediately,
    isNotify,
  ];
}
