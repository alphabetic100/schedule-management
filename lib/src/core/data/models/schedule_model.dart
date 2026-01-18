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
  final int colorValue;
  final double colorOpacity;

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
    this.colorValue = 0xFF960000, // Default primary color
    this.colorOpacity = 1.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isDone': isDone,
      'isMeeting': isMeeting,
      'meetingLink': meetingLink,
      'lauchImmediately': lauchImmediately,
      'isNotify': isNotify,
      'colorValue': colorValue,
      'colorOpacity': colorOpacity,
    };
  }

  factory ScheduleModel.fromFirestore(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      isDone: map['isDone'] ?? false,
      isMeeting: map['isMeeting'] ?? false,
      meetingLink: map['meetingLink'],
      lauchImmediately: map['lauchImmediately'] ?? false,
      isNotify: map['isNotify'] ?? false,
      colorValue: map['colorValue'] ?? 0xFF960000,
      colorOpacity: (map['colorOpacity'] ?? 1.0).toDouble(),
    );
  }

  ScheduleModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    bool? isDone,
    bool? isMeeting,
    String? meetingLink,
    bool? lauchImmediately,
    bool? isNotify,
    int? colorValue,
    double? colorOpacity,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDone: isDone ?? this.isDone,
      isMeeting: isMeeting ?? this.isMeeting,
      meetingLink: meetingLink ?? this.meetingLink,
      lauchImmediately: lauchImmediately ?? this.lauchImmediately,
      isNotify: isNotify ?? this.isNotify,
      colorValue: colorValue ?? this.colorValue,
      colorOpacity: colorOpacity ?? this.colorOpacity,
    );
  }

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
    colorValue,
    colorOpacity,
  ];
}
