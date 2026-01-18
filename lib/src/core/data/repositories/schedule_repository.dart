import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleModel>> getSchedules(DateTime date);
  Future<List<ScheduleModel>> getSchedulesForMonth(DateTime month);
  Future<void> addSchedule(ScheduleModel schedule);
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ScheduleModel>> getSchedules(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final snapshot =
        await _firestore
            .collection('schedules')
            .where('date', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
            .where('date', isLessThanOrEqualTo: endOfDay.toIso8601String())
            .get();

    return snapshot.docs
        .map((doc) => ScheduleModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<List<ScheduleModel>> getSchedulesForMonth(DateTime month) async {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final snapshot =
        await _firestore
            .collection('schedules')
            .where('date', isGreaterThanOrEqualTo: firstDay.toIso8601String())
            .where('date', isLessThanOrEqualTo: lastDay.toIso8601String())
            .get();

    return snapshot.docs
        .map((doc) => ScheduleModel.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<void> addSchedule(ScheduleModel schedule) async {
    await _firestore
        .collection('schedules')
        .doc(schedule.id)
        .set(schedule.toMap());
  }
}
