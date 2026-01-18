import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule_management/src/app/features/schedules/bloc/schedule_bloc.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/empty_schedule_widget.dart';
import 'package:schedule_management/src/app/features/schedules/widgets/schedule_widget.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleBodyWidget extends StatelessWidget {
  const ScheduleBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen:
          (previous, current) =>
              previous.selectedDate != current.selectedDate ||
              previous.schedules != current.schedules,
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: _DateHeaderDelegate(selectedDate: state.selectedDate),
            ),

            if (state.schedules.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: AppColors.primaryColor),
                      left: BorderSide(width: 1, color: AppColors.primaryColor),
                      right: BorderSide(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, AppColors.backgroundColor],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(child: EmptyScheduleWidget()),
                ),
              )
            else ...[
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top:
                            index == 0
                                ? BorderSide(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                )
                                : BorderSide.none,
                        left: BorderSide(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: index == 0 ? 20 : 0,
                      left: 16,
                      right: 16,
                      bottom: index == state.schedules.length - 1 ? 10 : 0,
                    ),
                    child: ScheduleWidget(schedule: state.schedules[index]),
                  );
                }, childCount: state.schedules.length),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 1, color: AppColors.primaryColor),
                      right: BorderSide(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, AppColors.backgroundColor],
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _DateHeaderDelegate extends SliverPersistentHeaderDelegate {
  final DateTime selectedDate;

  _DateHeaderDelegate({required this.selectedDate});

  @override
  double get minExtent => 44.0;

  @override
  double get maxExtent => 44.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor, // Opaque to hide scrolling content
        border: Border(
          top: BorderSide(width: 1, color: AppColors.secondaryColor),
          left: BorderSide(width: 1, color: AppColors.secondaryColor),
          right: BorderSide(width: 1, color: AppColors.secondaryColor),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.circle, color: AppColors.primaryColor, size: 12),
            SizedBox(width: 10),
            Text(
              DateFormat('EEEE, dd MMM, yyyy').format(selectedDate),
              style: context.bodyMedium.copyWith(
                color: AppColors.primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_DateHeaderDelegate oldDelegate) {
    return selectedDate != oldDelegate.selectedDate;
  }
}
