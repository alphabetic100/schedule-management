import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/create_schedule_bloc.dart';
import 'package:schedule_management/src/app/features/schedules/mixins/time_picker_mixin.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_form_widgets.dart';
import 'package:schedule_management/src/core/common/widgets/custom_button.dart';
import 'package:schedule_management/src/core/data/repositories/schedule_repository.dart';
import 'package:schedule_management/src/core/di/service_locator.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateScheduleScreen extends StatelessWidget {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CreateScheduleBloc(scheduleRepository: sl<ScheduleRepository>()),
      child: const CreateScheduleView(),
    );
  }
}

class CreateScheduleView extends StatefulWidget {
  const CreateScheduleView({super.key});

  @override
  State<CreateScheduleView> createState() => _CreateScheduleViewState();
}

class _CreateScheduleViewState extends State<CreateScheduleView>
    with TimePickerMixin {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _meetingLinkController = TextEditingController();
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _meetingLinkFocus = FocusNode();
  bool _isCalendarExpanded = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _meetingLinkController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _meetingLinkFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return BlocConsumer<CreateScheduleBloc, CreateScheduleState>(
      listener: (context, state) {
        if (state.status == CreateScheduleStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Schedule created successfully')),
          );
          context.pop();
        } else if (state.status == CreateScheduleStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to create schedule'),
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: Color(
                state.colorValue,
              ).withValues(alpha: state.opacity),
              elevation: 0,
              title: const Text('Create Schedule'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => context.pop(),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ScheduleSectionTitle(title: 'Details'),
                  const SizedBox(height: 12),
                  ScheduleTextField(
                    label: 'Title',
                    hintText: 'Schedule Title',
                    controller: _titleController,
                    focusNode: _titleFocus,
                    icon: Icons.title,
                    onChanged:
                        (value) => context.read<CreateScheduleBloc>().add(
                          TitleChanged(value),
                        ),
                  ),
                  const SizedBox(height: 12),
                  ScheduleTextField(
                    label: 'Description',
                    hintText: 'Description (optional)',
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    maxLines: 3,
                    icon: Icons.description_outlined,
                    onChanged:
                        (value) => context.read<CreateScheduleBloc>().add(
                          DescriptionChanged(value),
                        ),
                  ),
                  const SizedBox(height: 24),
                  const ScheduleSectionTitle(title: 'Date & Time'),
                  const SizedBox(height: 12),
                  SchedulePickerField(
                    label: 'Date',
                    value:
                        state.date == null
                            ? 'Select Date'
                            : DateFormat(
                              'EEEE, MMM dd, yyyy',
                            ).format(state.date!),
                    icon: Icons.calendar_today,
                    onTap: () {
                      _titleFocus.unfocus();
                      _descriptionFocus.unfocus();
                      _meetingLinkFocus.unfocus();
                      FocusScope.of(context).unfocus();
                      setState(
                        () => _isCalendarExpanded = !_isCalendarExpanded,
                      );
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child:
                        _isCalendarExpanded
                            ? Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TableCalendar(
                                firstDay: DateTime.now(),
                                lastDay: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                                focusedDay: state.date ?? DateTime.now(),
                                calendarFormat: CalendarFormat.month,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                rowHeight: 40,
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextStyle: context.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  leftChevronIcon: Icon(
                                    Icons.chevron_left,
                                    color: AppColors.primaryColor,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.chevron_right,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: context.bodySmall.copyWith(
                                    color: AppColors.primaryTextColor,
                                  ),
                                  weekendStyle: context.bodySmall.copyWith(
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                calendarStyle: CalendarStyle(
                                  selectedTextStyle: context.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  todayTextStyle: context.bodySmall.copyWith(
                                    color: AppColors.primaryTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  defaultTextStyle: context.bodySmall.copyWith(
                                    color: Colors.black,
                                  ),
                                  weekendTextStyle: context.bodySmall.copyWith(
                                    color: Colors.black,
                                  ),
                                  outsideTextStyle: context.bodySmall.copyWith(
                                    color: AppColors.secondaryTextColor,
                                  ),
                                  outsideDaysVisible: false,
                                  selectedDecoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: AppColors.secondaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  cellMargin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8,
                                  ),
                                ),
                                selectedDayPredicate:
                                    (day) => isSameDay(day, state.date),
                                onDaySelected: (selectedDay, focusedDay) {
                                  context.read<CreateScheduleBloc>().add(
                                    DateChanged(selectedDay),
                                  );
                                  setState(() => _isCalendarExpanded = false);
                                },
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SchedulePickerField(
                          label: 'Start',
                          value:
                              state.startTime == null
                                  ? 'Set Time'
                                  : DateFormat(
                                    'hh:mm a',
                                  ).format(state.startTime!),
                          icon: Icons.access_time,
                          onTap: () {
                            _titleFocus.unfocus();
                            _descriptionFocus.unfocus();
                            _meetingLinkFocus.unfocus();
                            FocusScope.of(context).unfocus();
                            showAppTimePicker(
                              context: context,
                              initialTime: state.startTime ?? DateTime.now(),
                              onTimeSelected:
                                  (dateTime) => context
                                      .read<CreateScheduleBloc>()
                                      .add(StartTimeChanged(dateTime)),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SchedulePickerField(
                          label: 'End',
                          value:
                              state.endTime == null
                                  ? 'Set Time'
                                  : DateFormat(
                                    'hh:mm a',
                                  ).format(state.endTime!),
                          icon: Icons.access_time_filled,
                          onTap: () {
                            _titleFocus.unfocus();
                            _descriptionFocus.unfocus();
                            _meetingLinkFocus.unfocus();
                            FocusScope.of(context).unfocus();
                            showAppTimePicker(
                              context: context,
                              initialTime:
                                  state.endTime ??
                                  state.startTime?.add(
                                    const Duration(hours: 1),
                                  ) ??
                                  DateTime.now().add(const Duration(hours: 1)),
                              onTimeSelected:
                                  (dateTime) => context
                                      .read<CreateScheduleBloc>()
                                      .add(EndTimeChanged(dateTime)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const ScheduleSectionTitle(title: 'Settings'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ScheduleCompactSwitch(
                          icon: Icons.video_camera_front,
                          label: 'Online Meeting',
                          value: state.isMeeting,
                          onChanged:
                              (value) => context.read<CreateScheduleBloc>().add(
                                MeetingToggled(value),
                              ),
                        ),
                        if (state.isMeeting) ...[
                          const Divider(height: 16),
                          ScheduleTextField(
                            label: 'Meeting Link',
                            hintText: 'Add meeting link (optional)',
                            controller: _meetingLinkController,
                            focusNode: _meetingLinkFocus,
                            icon: Icons.link,
                            onChanged:
                                (value) => context
                                    .read<CreateScheduleBloc>()
                                    .add(MeetingLinkChanged(value)),
                            suffix: IconButton(
                              icon: const Icon(Icons.content_paste, size: 18),
                              onPressed: () async {
                                final data = await Clipboard.getData(
                                  'text/plain',
                                );
                                if (data?.text != null) {
                                  _meetingLinkController.text = data!.text!;
                                  if (!context.mounted) return;
                                  context.read<CreateScheduleBloc>().add(
                                    MeetingLinkChanged(data.text!),
                                  );
                                }
                              },
                            ),
                          ),
                          const Divider(height: 16),
                          ScheduleCompactSwitch(
                            icon: Icons.rocket_launch,
                            label: 'Launch Immediately',
                            value: state.launchImmediately,
                            infoTooltip:
                                'Automatically launch the meeting app when it is time.',
                            onChanged:
                                (value) => context
                                    .read<CreateScheduleBloc>()
                                    .add(LaunchImmediatelyToggled(value)),
                          ),
                        ],
                        const Divider(height: 16),
                        ScheduleCompactSwitch(
                          icon: Icons.notifications_active,
                          label: 'Send Notification',
                          value: state.isNotify,
                          onChanged:
                              (value) => context.read<CreateScheduleBloc>().add(
                                NotifyToggled(value),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ScheduleColorPicker(
                    selectedColor: state.colorValue,
                    opacity: state.opacity,
                    onColorChanged:
                        (value) => context.read<CreateScheduleBloc>().add(
                          ColorValueChanged(value),
                        ),
                    onOpacityChanged:
                        (value) => context.read<CreateScheduleBloc>().add(
                          OpacityChanged(value),
                        ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, bottomPadding + 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: 'CANCEL',
                      onPressed: () => context.pop(),
                      color: Colors.grey[200]!,
                      textStyle: context.bodyMedium.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label:
                          state.status == CreateScheduleStatus.loading
                              ? 'SAVING...'
                              : 'SAVE SCHEDULE',
                      color: Color(
                        state.colorValue,
                      ).withValues(alpha: state.opacity),
                      onPressed:
                          state.status == CreateScheduleStatus.loading
                              ? () {}
                              : () => context.read<CreateScheduleBloc>().add(
                                const SubmitSchedule(),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
