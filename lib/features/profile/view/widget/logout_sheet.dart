import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/responsive_helper.dart';

class LogoutSheet extends StatelessWidget {
  final Future<void> Function() onConfirm;

  const LogoutSheet({super.key, required this.onConfirm});

  static void show(BuildContext context,
      {required Future<void> Function() onConfirm}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => LogoutSheet(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.r24)),
      ),
      padding:
          EdgeInsets.fromLTRB(r.s24, r.s16, r.s24, r.bottomPadding + r.s24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: r.s40,
            height: r.s4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(r.s2),
            ),
          ),
          SizedBox(height: r.s24),

          // Icon badge
          Container(
            width: r.s64,
            height: r.s64,
            decoration: BoxDecoration(
              color: const Color(0xFF042E60).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.logout_rounded,
                color: const Color(0xFF042E60), size: r.i28),
          ),
          SizedBox(height: r.s16),

          // Title
          Text('Logout',
              style: TextStyle(
                  fontSize: r.f20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A))),
          SizedBox(height: r.s8),

          // Subtitle
          Text(
            'You will be signed out of your account.\nYou can always log back in.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: r.f13, color: Colors.grey, height: 1.5),
          ),
          SizedBox(height: r.s28),

          // Buttons row
          Row(
            children: [
              // Cancel
              Expanded(
                child: SizedBox(
                  height: r.h52,
                  child: OutlinedButton(
                    onPressed: Get.back,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF042E60),
                      side: const BorderSide(color: Color(0xFF042E60)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(r.r8)),
                    ),
                    child: Text('Cancel',
                        style: TextStyle(
                            fontSize: r.f15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(width: r.s12),

              // Confirm logout
              Expanded(
                child: _LogoutButton(onConfirm: onConfirm, r: r),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatefulWidget {
  final Future<void> Function() onConfirm;
  final ResponsiveHelper r;
  const _LogoutButton({required this.onConfirm, required this.r});

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.r;
    return SizedBox(
      height: r.h52,
      child: ElevatedButton(
        onPressed: _loading
            ? null
            : () async {
                setState(() => _loading = true);
                await widget.onConfirm();
                if (mounted) setState(() => _loading = false);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF042E60),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF042E60).withOpacity(0.6),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(r.r8)),
        ),
        child: _loading
            ? SizedBox(
                width: r.s20,
                height: r.s20,
                child: const CircularProgressIndicator(
                    strokeWidth: 2.5, color: Colors.white))
            : Text('Logout',
                style: TextStyle(fontSize: r.f15, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
