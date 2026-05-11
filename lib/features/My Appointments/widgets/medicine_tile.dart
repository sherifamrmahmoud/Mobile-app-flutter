import 'package:flutter/material.dart';

class MedicineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;

  const MedicineTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF7F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: const Icon(
              Icons.medication_outlined,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              duration,
              style: TextStyle(
                color: Colors.green.shade800,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}