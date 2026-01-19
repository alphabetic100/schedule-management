import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/core/data/models/schedule_model.dart';
import 'package:schedule_management/src/core/data/repositories/schedule_repository.dart';
import 'package:uuid/uuid.dart';

part 'create_schedule_event.dart';
part 'create_schedule_state.dart';

class CreateScheduleBloc
    extends Bloc<CreateScheduleEvent, CreateScheduleState> {
  final ScheduleRepository _scheduleRepository;

  CreateScheduleBloc({required ScheduleRepository scheduleRepository})
    : _scheduleRepository = scheduleRepository,
      super(const CreateScheduleState()) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<DateChanged>(_onDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<EndTimeChanged>(_onEndTimeChanged);
    on<MeetingToggled>(_onMeetingToggled);
    on<MeetingLinkChanged>(_onMeetingLinkChanged);
    on<LaunchImmediatelyToggled>(_onLaunchImmediatelyToggled);
    on<NotifyToggled>(_onNotifyToggled);
    on<ColorValueChanged>(_onColorValueChanged);
    on<OpacityChanged>(_onOpacityChanged);
    on<InitializeEditMode>(_onInitializeEditMode);
    on<SubmitSchedule>(_onSubmitSchedule);
  }

  void _onInitializeEditMode(
    InitializeEditMode event,
    Emitter<CreateScheduleState> emit,
  ) {
    final s = event.schedule;
    emit(
      state.copyWith(
        title: s.title,
        description: s.description,
        date: s.date,
        startTime: s.startTime,
        endTime: s.endTime,
        isMeeting: s.isMeeting,
        meetingLink: s.meetingLink,
        launchImmediately: s.lauchImmediately,
        isNotify: s.isNotify,
        colorValue: s.colorValue,
        opacity: s.colorOpacity,
        initialSchedule: s,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onColorValueChanged(
    ColorValueChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        colorValue: event.colorValue,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onOpacityChanged(
    OpacityChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        opacity: event.opacity,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onTitleChanged(TitleChanged event, Emitter<CreateScheduleState> emit) {
    emit(
      state.copyWith(title: event.title, status: CreateScheduleStatus.initial),
    );
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onDateChanged(DateChanged event, Emitter<CreateScheduleState> emit) {
    emit(
      state.copyWith(date: event.date, status: CreateScheduleStatus.initial),
    );
  }

  void _onStartTimeChanged(
    StartTimeChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        startTime: event.startTime,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onEndTimeChanged(
    EndTimeChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        endTime: event.endTime,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onMeetingToggled(
    MeetingToggled event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        isMeeting: event.isMeeting,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onMeetingLinkChanged(
    MeetingLinkChanged event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        meetingLink: event.meetingLink,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onLaunchImmediatelyToggled(
    LaunchImmediatelyToggled event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        launchImmediately: event.launchImmediately,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  void _onNotifyToggled(
    NotifyToggled event,
    Emitter<CreateScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        isNotify: event.isNotify,
        status: CreateScheduleStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitSchedule(
    SubmitSchedule event,
    Emitter<CreateScheduleState> emit,
  ) async {
    if (state.title.isEmpty) {
      emit(
        state.copyWith(
          status: CreateScheduleStatus.failure,
          errorMessage: 'Title cannot be empty',
        ),
      );
      return;
    }
    if (state.date == null) {
      emit(
        state.copyWith(
          status: CreateScheduleStatus.failure,
          errorMessage: 'Date must be selected',
        ),
      );
      return;
    }
    if (state.startTime == null || state.endTime == null) {
      emit(
        state.copyWith(
          status: CreateScheduleStatus.failure,
          errorMessage: 'Start and End times must be selected',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CreateScheduleStatus.loading));

    try {
      final scheduleDate = state.date!;
      // Ensure startTime and endTime have the correct date component
      final normalizedStart = DateTime(
        scheduleDate.year,
        scheduleDate.month,
        scheduleDate.day,
        state.startTime!.hour,
        state.startTime!.minute,
      );
      var normalizedEnd = DateTime(
        scheduleDate.year,
        scheduleDate.month,
        scheduleDate.day,
        state.endTime!.hour,
        state.endTime!.minute,
      );

      // If end time is before start time, it means it ends the next day
      if (normalizedEnd.isBefore(normalizedStart)) {
        normalizedEnd = normalizedEnd.add(const Duration(days: 1));
      }

      final schedule =
          state.isEdit
              ? state.initialSchedule!.copyWith(
                title: state.title,
                description: state.description,
                date: scheduleDate,
                startTime: normalizedStart,
                endTime: normalizedEnd,
                isMeeting: state.isMeeting,
                meetingLink: state.meetingLink,
                lauchImmediately: state.launchImmediately,
                isNotify: state.isNotify,
                colorValue: state.colorValue,
                colorOpacity: state.opacity,
              )
              : ScheduleModel(
                id: const Uuid().v4(),
                title: state.title,
                description: state.description,
                date: scheduleDate,
                startTime: normalizedStart,
                endTime: normalizedEnd,
                isMeeting: state.isMeeting,
                meetingLink: state.meetingLink,
                lauchImmediately: state.launchImmediately,
                isNotify: state.isNotify,
                colorValue: state.colorValue,
                colorOpacity: state.opacity,
              );

      await _scheduleRepository.addSchedule(schedule);
      emit(
        state.copyWith(
          status: CreateScheduleStatus.success,
          finalSchedule: schedule,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateScheduleStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
