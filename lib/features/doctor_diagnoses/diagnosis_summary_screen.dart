import 'package:flutter/material.dart';
import '../My Appointments/widgets/doctor_card.dart';
import '../My Appointments/widgets/medicine_tile.dart';
import '../My Appointments/widgets/section_card.dart';

class DiagnosisSummaryScreen extends StatelessWidget {
  const DiagnosisSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "MEDI CALL",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Doctor’s Diagnosis",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const DoctorCard(),

            const SizedBox(height: 20),

            SectionCard(
              title: "Consultation Details",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [

                  SizedBox(height: 10),

                  Text(
                    "Diagnosis Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Patient presents with mild hypertension and reported occasional fatigue. Heart rate is within normal limits but shows slight elevation during stress tests.",
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SectionCard(
              title: "Prescribed Medications",
              child: Column(
                children: const [

                  SizedBox(height: 10),

                  MedicineTile(
                    title: "Lisinopril 10mg",
                    subtitle: "Once daily after breakfast",
                    duration: "30 Days",
                  ),

                  SizedBox(height: 12),

                  MedicineTile(
                    title: "Magnesium Citrate",
                    subtitle: "Once daily",
                    duration: "Ongoing",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SectionCard(
              title: "Doctor’s Notes",
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.orange.shade200,
                  ),
                ),
                child: const Text(
                  "Follow up in 2 weeks and maintain blood pressure readings daily.",
                  style: TextStyle(
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                icon: const Icon(Icons.download),

                label: const Text(
                  "Download PDF Summary",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}