import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart'; // تأكد من المسار

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.shield_outlined,
                color: ColorsManager.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Latest Summary",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Overall health is stable. Recommended follow-up in 3 months.",
            style: TextStyle(color: ColorsManager.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 12),

          // الزرار اللي مش راضي يشتغل - عدله كدا بالظبط:
          InkWell(
            onTap: () {
              // تأكد إن '/diagnosis' مكتوبة كدا بالظبط في الـ main.dart
              Navigator.pushNamed(context, '/sumarry');
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Detailed Report",
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: ColorsManager.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
