
import 'package:flutter/material.dart';
import 'package:nti5/features/My%20Appointments/widgets/appointment_card.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TITLE
              const Text(
                "My Appointments",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// TABS
              Row(
                children: const [
                  Text(
                    "Upcoming",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    "Past",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView(
                  children: const [

                    AppointmentCard(
                      doctorName: "Dr. Sarah Jenkins",
                      specialty: "Cardiologist",
                      date: "Oct 24, 2023",
                      time: "10:30 AM",
                    ),

                    SizedBox(height: 20),

                    AppointmentCard(
                      doctorName: "Dr. Michael Chen",
                      specialty: "Dermatologist",
                      date: "Oct 25, 2023",
                      time: "02:00 PM",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}