import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class VoiceEntryScreen extends StatelessWidget {
  const VoiceEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScroll(
      children: [
        AppCard(
          child: Column(
            children: [
              const Text(
                'Recognized Text',
                style: TextStyle(
                  color: C.secondary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 120),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: C.surfaceLow,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.outlineLight),
                ),
                child: const Center(
                  child: Text(
                    'احمد نے 2 کلو آٹا لیا 200 روپے میں',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, height: 1.6, color: C.muted),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 210,
                height: 210,
                decoration: const BoxDecoration(
                  color: Color(0x1A2E7D32),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Color(0x262E7D32),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: C.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: C.primary.withAlpha(82),
                      blurRadius: 38,
                      spreadRadius: 12,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic_rounded,
                  color: Colors.white,
                  size: 68,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'بولیں: "احمد نے 2 کلو آٹا لیا 200 روپے میں"',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: C.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Say: "Ahmed bought 2kg flour for 200 rupees"',
          textAlign: TextAlign.center,
          style: TextStyle(color: C.outline, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Center(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/manual'),
            icon: const Icon(Icons.keyboard_rounded),
            label: const Text('Manual Entry'),
          ),
        ),
        const SizedBox(height: 26),
        PrimaryButton(
          label: 'Confirm Selection',
          icon: Icons.check_circle_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}
