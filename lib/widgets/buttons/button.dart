import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isActive,
      this.color,
      this.height,
      this.width,
      this.prefixIcon});

  final String text;
  final VoidCallback onTap;
  final bool isActive;
  final double? width;
  final Color? color;
  final double? height;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isActive ? onTap : () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: isActive
                ? color ?? AppColors.primary
                : AppColors.black,
            foregroundColor:
                isActive ? AppColors.primary : AppColors.black),
        child: Container(
          height: height ?? 67,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                const SizedBox(
                  width: 8,
                )
              ],
              Text(
                text,
                style: AppTypography.font18w500
                    .copyWith(color: isActive ? Colors.black : Colors.white),
              ),
            ],
          ),
        ));
  }
}
