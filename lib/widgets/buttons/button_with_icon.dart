import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isActive,
      this.height = 67,
      required this.icon});

  final String text;
  final Widget icon;
  final VoidCallback onTap;
  final bool isActive;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isActive ? onTap : () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: isActive ? Colors.white : AppColors.black,
            foregroundColor: isActive ? Colors.white : AppColors.black),
        child: Container(
            height: height,
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: AppTypography.f18w500
                      .copyWith(color: isActive ? Colors.black : Colors.white),
                ),
              ],
            )));
  }
}
