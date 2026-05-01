import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const items = [
      OnboardItem(
        Icons.mic_rounded,
        'Voice se hisaab rakhein',
        'آواز سے حساب رکھیں',
        'Speak sales, purchases, and udhaar naturally. DukanDost understands your shop language and fills in the details for you.',
      ),
      OnboardItem(
        Icons.receipt_long_rounded,
        'Track udhaar easily',
        'ادھار آسانی سے ٹریک کریں',
        'See pending customers, send reminders, and never lose handwritten notes again.',
      ),
      OnboardItem(
        Icons.bar_chart_rounded,
        'Reports at a glance',
        'ماہانہ رپورٹ دیکھیں',
        'Daily sales, low-stock alerts, and monthly snapshots stay ready when you need them.',
      ),
    ];

    return Scaffold(
      appBar: const BrandAppBar(showSettings: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) => setState(() => page = value),
                  children: items,
                ),
              ),
              Dots(count: items.length, active: page),
              const SizedBox(height: 22),
              PrimaryButton(
                label: page == items.length - 1 ? 'Get Started' : 'Next',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  if (page == items.length - 1) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    color: C.outline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
