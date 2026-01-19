import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class ScheduleSectionTitle extends StatelessWidget {
  final String title;

  const ScheduleSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.bodyLarge.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryTextColor,
      ),
    );
  }
}

class ScheduleTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;
  final ValueChanged<String> onChanged;
  final Widget? suffix;
  final FocusNode? focusNode;

  const ScheduleTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
    required this.onChanged,
    this.suffix,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
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
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            onChanged: onChanged,
            style: context.bodyMedium.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.bodyMedium.copyWith(
                color: AppColors.secondaryTextColor.withValues(alpha: 0.5),
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.secondaryTextColor,
                size: 20,
              ),
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class SchedulePickerField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const SchedulePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.05 * 255).round()),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.secondaryTextColor, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: context.bodyMedium.copyWith(
                      color:
                          value.startsWith('Select') || value == 'Set Time'
                              ? AppColors.secondaryTextColor
                              : AppColors.primaryColor,
                      fontWeight:
                          value.startsWith('Select') || value == 'Set Time'
                              ? FontWeight.normal
                              : FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.secondaryTextColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ScheduleCompactSwitch extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? infoTooltip;

  const ScheduleCompactSwitch({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.infoTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.secondaryTextColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: context.bodyMedium.copyWith(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (infoTooltip != null)
          Tooltip(
            message: infoTooltip!,
            triggerMode: TooltipTriggerMode.tap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.info_outline,
                size: 18,
                color: AppColors.secondaryTextColor,
              ),
            ),
          ),
        Transform.scale(
          scaleX: 0.7,
          scaleY: 0.6,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primaryColor,
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryColor.withValues(alpha: 0.5);
              }
              return AppColors.backgroundColor;
            }),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryColor;
              }
              return Colors.grey[400];
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}

class ScheduleColorPicker extends StatelessWidget {
  final int selectedColor;
  final double opacity;
  final ValueChanged<int> onColorChanged;
  final ValueChanged<double> onOpacityChanged;

  const ScheduleColorPicker({
    super.key,
    required this.selectedColor,
    required this.opacity,
    required this.onColorChanged,
    required this.onOpacityChanged,
  });

  static const List<int> colors = [
    0xFF960000,
    0xFF00962D,
    0xFF005E96,
    0xFF965E00,
    0xFF6A0096,
    0xFF96005E,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScheduleSectionTitle(title: 'Color & Appearance'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Color',
                style: context.bodySmall.copyWith(
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    colors.map((colorValue) {
                      final isSelected = selectedColor == colorValue;
                      return GestureDetector(
                        onTap: () => onColorChanged(colorValue),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(colorValue),
                            shape: BoxShape.circle,
                            border:
                                isSelected
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: Color(
                                    colorValue,
                                  ).withValues(alpha: 0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child:
                              isSelected
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                  : null,
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Opacity',
                    style: context.bodySmall.copyWith(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${(opacity * 100).toInt()}%',
                    style: context.bodySmall.copyWith(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: Color(selectedColor),
                  inactiveTrackColor: AppColors.backgroundColor,
                  thumbColor: Color(selectedColor),
                  overlayColor: Color(selectedColor).withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: opacity,
                  min: 0.1,
                  max: 1.0,
                  onChanged: onOpacityChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
