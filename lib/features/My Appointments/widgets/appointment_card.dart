// appointment_card.dart

import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {

  final String doctorName;
  final String specialty;
  final String date;
  final String time;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Row(
            children: [

              const CircleAvatar(radius: 28),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      specialty,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [

                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 5),

                        Text(date),

                        const SizedBox(width: 14),

                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 5),

                        Text(time),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Join Meeting"),
            ),
          ),
        ],
      ),
    );
  }
}