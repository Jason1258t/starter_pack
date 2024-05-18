import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.validator,
      required this.controller,
      this.prefixIcon,
      this.hintText,
      this.labelText,
      this.obscured = false,
      this.suffixIcon,
      this.keyboardType,
      this.onChange,
      this.initValue,
      this.onTap,
      this.padding,
      this.backgroundColor,
      this.borderRadius,
      this.showCursor});

  final String? Function(String?)? validator;
  final TextEditingController controller;

  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final bool obscured;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String?)? onChange;
  final String? initValue;
  final Function()? onTap;
  final bool? showCursor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTypography.f14w400.copyWith(color: AppColors.black),
          ),
          const SizedBox(
            height: 10,
          )
        ],
        Container(
          decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.black,
              borderRadius:borderRadius ??  BorderRadius.circular(9)),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          alignment: Alignment.center,
          child: TextFormField(
            textAlign: TextAlign.left,
            showCursor: showCursor,
            onTap: onTap,
            onChanged: onChange,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscured,
            initialValue: initValue,
            style: AppTypography.f16w500,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: prefixIcon,
                ),
                errorStyle: const TextStyle(
                  fontSize: 0,
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 30,
                  maxHeight: 20,
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 20,
                  maxHeight: 20,
                ),
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.all(2),
                hintText: hintText,
                hintStyle:
                    AppTypography.f16w500.copyWith(color: AppColors.black),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
