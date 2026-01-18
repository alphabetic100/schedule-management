import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_body_widget.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_calander_view.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/week_view_widget.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';
import 'package:schedule_management/src/core/data/repositories/schedule_repository.dart';
import 'package:schedule_management/src/core/di/service_locator.dart';
import 'package:schedule_management/src/core/extensions/app_size.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ScheduleBloc(scheduleRepository: sl<ScheduleRepository>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverAppBar(
                      expandedHeight: context.height * 0.40,
                      collapsedHeight: context.height * 0.15,
                      floating: false,
                      pinned: true,
                      backgroundColor: AppColors.backgroundColor,
                      surfaceTintColor: AppColors.backgroundColor,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          final expandedHeight = context.height * 0.40;
                          final collapsedHeight = context.height * 0.15;
                          final currentHeight = constraints.maxHeight;

                          final t = ((currentHeight - collapsedHeight) /
                                  (expandedHeight - collapsedHeight))
                              .clamp(0.0, 1.0);
                          final isCollapsed = t < 0.5;

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              if (!isCollapsed)
                                Opacity(
                                  opacity: t,
                                  child: ClipRect(
                                    child: OverflowBox(
                                      maxHeight: double.infinity,
                                      child: const RepaintBoundary(
                                        child: ScheduleCalanderView(),
                                      ),
                                    ),
                                  ),
                                ),

                              if (isCollapsed)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Opacity(
                                    opacity: 1 - t,
                                    child: const RepaintBoundary(
                                      child: WeekViewWidget(),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ];
              },
              body: ScheduleBodyWidget(),
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () async {
                await context.push(RouteName.createSchedule);
                if (context.mounted) {
                  context.read<ScheduleBloc>().add(const ScheduleRefreshed());
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
