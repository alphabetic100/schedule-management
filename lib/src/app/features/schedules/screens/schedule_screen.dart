import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_body_widget.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_calander_view.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';
import 'package:schedule_management/src/core/extensions/app_size.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: context.height * 0.40,
              collapsedHeight: context.height * 0.15,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundColor,
              surfaceTintColor: AppColors.backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                background: ScheduleCalanderView(),
              ),
            ),
          ];
        },
        body: ScheduleBodyWidget(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          context.push(RouteName.createSchedule);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
