import 'package:flutter/cupertino.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

mixin TimePickerMixin {
  void showAppTimePicker({
    required BuildContext context,
    required DateTime initialTime,
    required Function(DateTime) onTimeSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        DateTime selectedTime = initialTime;
        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Time',
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onTimeSelected(selectedTime);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'DONE',
                      style: context.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: flutter.CupertinoTimerPicker(
                  mode: flutter.CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(
                    hours: initialTime.hour,
                    minutes: initialTime.minute,
                  ),
                  onTimerDurationChanged: (duration) {
                    selectedTime = DateTime(
                      initialTime.year,
                      initialTime.month,
                      initialTime.day,
                      duration.inHours,
                      duration.inMinutes % 60,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
