import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PRIMARY PHYSICIAN",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Dr. Sarah Mitchell",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Cardiology Specialist • 12 years exp.",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    _tag("Verified", Colors.blue),
                    const SizedBox(width: 8),
                    _tag("Available", Colors.green),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}