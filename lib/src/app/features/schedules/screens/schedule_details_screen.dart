import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
import 'package:schedule_management/src/app/features/schedules/screens/create_schedule_screen.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleDetailsScreen extends StatefulWidget {
  final ScheduleModel schedule;

  const ScheduleDetailsScreen({super.key, required this.schedule});

  @override
  State<ScheduleDetailsScreen> createState() => _ScheduleDetailsScreenState();
}

class _ScheduleDetailsScreenState extends State<ScheduleDetailsScreen> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;
  String _statusLabel = 'STARTS IN';
  late ScheduleModel _currentSchedule;

  @override
  void initState() {
    super.initState();
    _currentSchedule = widget.schedule;
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();

    // Anchor times to the schedule's date to avoid "creation-date poisoning"
    final start = DateTime(
      _currentSchedule.date.year,
      _currentSchedule.date.month,
      _currentSchedule.date.day,
      _currentSchedule.startTime.hour,
      _currentSchedule.startTime.minute,
    );

    var end = DateTime(
      _currentSchedule.date.year,
      _currentSchedule.date.month,
      _currentSchedule.date.day,
      _currentSchedule.endTime.hour,
      _currentSchedule.endTime.minute,
    );

    // Support overnight schedules
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }

    if (now.isBefore(start)) {
      setState(() {
        _statusLabel = 'STARTS IN';
        _remainingTime = start.difference(now);
      });
    } else if (now.isBefore(end)) {
      setState(() {
        _statusLabel = 'ENDS IN';
        _remainingTime = end.difference(now);
      });
    } else {
      setState(() {
        _statusLabel = 'COMPLETED';
        _remainingTime = Duration.zero;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    if (duration.inDays > 0) {
      String days = duration.inDays.toString();
      String hours = twoDigits(duration.inHours.remainder(24));
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));
      return "${days}D $hours:$minutes:$seconds";
    }

    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final scheduleColor = Color(
      _currentSchedule.colorValue,
    ).withValues(alpha: _currentSchedule.colorOpacity);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            stretch: true,
            backgroundColor: scheduleColor,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      scheduleColor,
                      scheduleColor.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      _statusLabel,
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatDuration(_remainingTime),
                      style: context.displayLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 52,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Section - Ultra Minimalist
                      Text(
                        DateFormat(
                          'EEEE, MMMM dd, yyyy',
                        ).format(_currentSchedule.date).toUpperCase(),
                        style: context.bodySmall.copyWith(
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Title - Very Large & Bold
                      Text(
                        _currentSchedule.title,
                        style: context.displaySmall.copyWith(
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          height: 1.0,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Time Section - Clean Row
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: scheduleColor,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${DateFormat('hh:mm a').format(_currentSchedule.startTime)} - ${DateFormat('hh:mm a').format(_currentSchedule.endTime)}',
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTextColor.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Description - Clean & Clear
                      Text(
                        _currentSchedule.description.isEmpty
                            ? 'No description provided.'
                            : _currentSchedule.description,
                        style: context.bodyLarge.copyWith(
                          color: AppColors.primaryTextColor.withValues(
                            alpha: 0.6,
                          ),
                          height: 1.6,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Settings Section
                      Row(
                        children: [
                          _buildStatusBadge(
                            context,
                            _currentSchedule.isNotify
                                ? 'Notifications: ON'
                                : 'Notifications: OFF',
                            _currentSchedule.isNotify
                                ? Colors.green
                                : Colors.grey,
                            Icons.notifications_active_rounded,
                          ),
                          const SizedBox(width: 12),
                          _buildStatusBadge(
                            context,
                            _currentSchedule.lauchImmediately
                                ? 'Auto-Launch'
                                : 'Manual Launch',
                            _currentSchedule.lauchImmediately
                                ? Colors.purple
                                : Colors.grey,
                            Icons.rocket_launch_rounded,
                          ),
                        ],
                      ),

                      if (_currentSchedule.isMeeting) ...[
                        const SizedBox(height: 32),
                        _buildMeetingSection(
                          context,
                          _currentSchedule.meetingLink,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(24, 16, 24, bottomPadding + 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Delete Button
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () => _showDeleteConfirmation(context),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Edit Button
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<ScheduleModel>(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateScheduleScreen(
                            initialSchedule: _currentSchedule,
                          ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _currentSchedule = result;
                    });
                    _calculateRemainingTime();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheduleColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_note_rounded, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'EDIT SCHEDULE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Delete Schedule'),
            content: const Text(
              'Are you sure you want to delete this schedule?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  context.read<ScheduleBloc>().add(
                    ScheduleDeleted(_currentSchedule.id),
                  );
                  Navigator.pop(dialogContext); // Close dialog
                  Navigator.pop(context); // Go back to list
                },
                child: const Text(
                  'DELETE',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildMeetingSection(BuildContext context, String? link) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.video_camera_front_rounded,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Online Meeting',
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
          if (link != null) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Handle link tap
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.link_rounded,
                      size: 18,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        link,
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
