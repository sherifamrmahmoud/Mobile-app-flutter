import 'package:flutter/material.dart';

// ignore: camel_case_types
class SummaryDiagnosis_Screen extends StatelessWidget {
  const SummaryDiagnosis_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Medical Diagnosis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- كارت ملخص الحالة الصحية ---
            _buildStatusHeader(),

            const SizedBox(height: 25.0),

            const Text(
              "Detailed Analysis",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),

            // --- تفاصيل القياسات الحيوية ---
            _buildInfoRow(
              "Blood Pressure",
              "120/80 mmHg",
              Icons.favorite,
              Colors.red,
            ),
            _buildInfoRow("Heart Rate", "72 bpm", Icons.speed, Colors.orange),
            _buildInfoRow(
              "Glucose Level",
              "95 mg/dL",
              Icons.water_drop,
              Colors.blue,
            ),
            _buildInfoRow(
              "Weight",
              "75 kg",
              Icons.monitor_weight,
              Colors.green,
            ),

            const SizedBox(height: 25.0),

            const Text(
              "Doctor's Notes",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),

            // --- ملاحظات الطبيب ---
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: const Text(
                "The patient's condition is significantly improving. All vital signs are within the normal range. Continue the prescribed medication for another two weeks and maintain a healthy diet.",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF0D47A1), // blue[900]
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30.0),

            // --- زرار تحميل التقرير ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text("Download PDF Report"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[800]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Health Status",
            style: TextStyle(color: Colors.white70, fontSize: 14.0),
          ),
          const SizedBox(height: 5.0),
          const Text(
            "Excellent & Stable",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15.0),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Last Updated: 11 May 2026",
                style: TextStyle(color: Colors.white70, fontSize: 12.0),
              ),
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 20.0),
            ),
            const SizedBox(width: 15.0),
            Text(
              label,
              style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
