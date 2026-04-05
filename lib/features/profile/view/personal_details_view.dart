import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/responsive_helper.dart';
import '../controller/profile_controller.dart';

class PersonalDetailsView extends StatelessWidget {
  const PersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final r = ResponsiveHelper(context);
    final p = c.profile;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 198, 222, 251),
              Color.fromARGB(255, 232, 241, 253)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── App bar ───────────────────────────────────────────
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: r.s16, vertical: r.s12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        width: r.s36,
                        height: r.s36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(r.r8),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: r.i16, color: const Color(0xFF042E60)),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Personal Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: r.f18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    SizedBox(width: r.s36), // balance back button
                  ],
                ),
              ),

              // ── Scrollable body ───────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(r.s16, r.s8, r.s16, r.s24),
                  child: Column(
                    children: [
                      // ── User card ─────────────────────────────────
                      _card(
                        r,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: r.s28,
                              backgroundColor: const Color(0xFFCCDDEE),
                              child: Icon(Icons.person,
                                  color: const Color(0xFF042E60), size: r.i28),
                            ),
                            SizedBox(width: r.s14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.name,
                                    style: TextStyle(
                                        fontSize: r.f16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1A1A1A))),
                                SizedBox(height: r.s4),
                                Text(p.email,
                                    style: TextStyle(
                                        fontSize: r.f12, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: r.s12),

                      // ── Personal details card ─────────────────────
                      _card(
                        r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Personal Details',
                                style: TextStyle(
                                    fontSize: r.f16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1A1A1A))),
                            SizedBox(height: r.s12),
                            _infoRow(r, 'Full Name', p.name),
                            _infoRow(r, 'Email', p.email),
                            _infoRow(r, 'Phone Number', p.phone),
                            _infoRow(r, 'Location', p.location),
                            _infoRow(r, 'Joined on', p.joinedOn, isLast: true),
                          ],
                        ),
                      ),
                      SizedBox(height: r.s12),

                      // ── Bank card ─────────────────────────────────
                      if (p.bankDetails != null)
                        _card(
                          r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bank & Payment Details',
                                  style: TextStyle(
                                      fontSize: r.f16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1A1A1A))),
                              SizedBox(height: r.s14),
                              Row(
                                children: [
                                  Container(
                                    width: r.s40,
                                    height: r.s40,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(r.r8),
                                    ),
                                    child: Icon(Icons.account_balance_rounded,
                                        color: Colors.red.shade400,
                                        size: r.i20),
                                  ),
                                  SizedBox(width: r.s12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(p.bankDetails!.bankName,
                                            style: TextStyle(
                                                fontSize: r.f14,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    const Color(0xFF1A1A1A))),
                                        Text(p.bankDetails!.accountHolder,
                                            style: TextStyle(
                                                fontSize: r.f12,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('View Details',
                                        style: TextStyle(
                                            fontSize: r.f12,
                                            color: const Color(0xFF042E60),
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(ResponsiveHelper r, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: r.s8,
            offset: Offset(0, r.s2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(ResponsiveHelper r, String label, String value,
      {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: r.s10),
          child: Row(
            children: [
              Text(label,
                  style: TextStyle(fontSize: r.f13, color: Colors.grey)),
              const Spacer(),
              Text(value,
                  style: TextStyle(
                      fontSize: r.f13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A1A))),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }
}
