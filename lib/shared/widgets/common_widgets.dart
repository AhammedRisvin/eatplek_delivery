import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_color.dart';

// ── text() ────────────────────────────────────────────────────────────────────
Widget text(
  String label, {
  double? fontSize,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.textPrimary,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  TextOverflow overflow = TextOverflow.ellipsis,
  double? letterSpacing,
  double? height,
  TextDecoration decoration = TextDecoration.none,
}) {
  return Text(
    label,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    ),
  );
}

// ── button() ──────────────────────────────────────────────────────────────────
Widget button({
  required String label,
  required VoidCallback onTap,
  Color backgroundColor = AppColor.primary,
  Color textColor = AppColor.white,
  double? fontSize,
  double borderRadius = 12,
  EdgeInsetsGeometry? padding,
  bool isLoading = false,
  bool isDisabled = false,
  double? width,
  double? height,
  Widget? prefixIcon,
}) {
  return SizedBox(
    width: width ?? double.infinity,
    height: height ?? 52,
    child: ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? AppColor.grey : backgroundColor,
        foregroundColor: textColor,
        disabledBackgroundColor: backgroundColor.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              width: (height ?? 52) * 0.42,
              height: (height ?? 52) * 0.42,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: textColor,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon,
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
    ),
  );
}

// ── buildCommonTextFormField() ────────────────────────────────────────────────
Widget buildCommonTextFormField({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  bool readOnly = false,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  Widget? prefixIcon,
  Widget? suffixIcon,
  int maxLines = 1,
  int? maxLength,
  EdgeInsetsGeometry? contentPadding,
  Color fillColor = AppColor.greyLight,
  double borderRadius = 12,
  bool autofocus = false,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    obscureText: obscureText,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    validator: validator,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    maxLines: maxLines,
    maxLength: maxLength,
    autofocus: autofocus,
    inputFormatters: inputFormatters,
    style: const TextStyle(fontSize: 15, color: AppColor.textPrimary),
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: const TextStyle(fontSize: 14, color: AppColor.textHint),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColor.greyBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColor.greyBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppColor.error),
      ),
    ),
  );
}
