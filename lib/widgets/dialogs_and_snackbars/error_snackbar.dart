import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AppSnackBars {
  static SnackBar snackBar(String text) => SnackBar(
        elevation: 0,
        content: Text(
          text,
          style: AppTypography.f14w400,
        ),
        backgroundColor: AppColors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      );
}
