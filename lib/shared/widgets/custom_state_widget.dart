import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

enum _StateType { empty, error, custom }

class CustomStateWidget extends StatelessWidget {
  final _StateType _type;
  final String? title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? icon;
  final Widget? customChild;

  const CustomStateWidget._({
    required _StateType type,
    this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.icon,
    this.customChild,
  }) : _type = type;

  factory CustomStateWidget.empty({
    String title = 'Nothing here yet',
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
    Widget? icon,
  }) =>
      CustomStateWidget._(
        type: _StateType.empty,
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
        icon: icon,
      );

  factory CustomStateWidget.error({
    String title = 'Something went wrong',
    String? subtitle,
    String actionLabel = 'Try Again',
    VoidCallback? onAction,
  }) =>
      CustomStateWidget._(
        type: _StateType.error,
        title: title,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  factory CustomStateWidget.custom({required Widget child}) =>
      CustomStateWidget._(type: _StateType.custom, customChild: child);

  @override
  Widget build(BuildContext context) {
    if (_type == _StateType.custom) return customChild!;

    final isError = _type == _StateType.error;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isError ? AppColor.error : AppColor.greyLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isError ? Icons.error_outline_rounded : Icons.inbox_rounded,
                    size: 40,
                    color: isError ? AppColor.error : AppColor.grey,
                  ),
                ),
            const SizedBox(height: 16),
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isError ? AppColor.error : AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(actionLabel!,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
