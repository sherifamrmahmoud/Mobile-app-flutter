import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Doctor's Diagnosis",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsManager.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shield_outlined, color: ColorsManager.success),
                  const SizedBox(width: 8),
                  const Text("Latest Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Text("Oct 24, 2024", style: TextStyle(color: ColorsManager.textSecondary, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '"Overall health is stable. Recommended follow-up in 3 months."',
                style: TextStyle(color: ColorsManager.textPrimary, height: 1.5),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("View Detailed Report", style: TextStyle(color: ColorsManager.primary)),
                    Icon(Icons.arrow_right_alt, color: ColorsManager.primary),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}