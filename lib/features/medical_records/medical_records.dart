import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////
class MedicalRecordModel {
  final String title;
  final String doctor;
  final String date;
  final IconData icon;

  MedicalRecordModel({
    required this.title,
    required this.doctor,
    required this.date,
    required this.icon,
  });
}

////////////////////////////////////////////////////////////
/// STATES
////////////////////////////////////////////////////////////
abstract class MedicalState {}

class MedicalInitial extends MedicalState {}

class MedicalLoading extends MedicalState {}

class MedicalLoaded extends MedicalState {
  final List<MedicalRecordModel> records;
  MedicalLoaded(this.records);
}

class MedicalError extends MedicalState {
  final String message;
  MedicalError(this.message);
}

////////////////////////////////////////////////////////////
/// CUBIT
////////////////////////////////////////////////////////////
class MedicalCubit extends Cubit<MedicalState> {
  MedicalCubit() : super(MedicalInitial());

  Future<void> getRecords() async {
    try {
      emit(MedicalLoading());
      await Future.delayed(const Duration(seconds: 1));
      final records = [
        MedicalRecordModel(
          title: 'General Checkup',
          doctor: 'Dr. Sarah Johnson',
          date: 'Oct 24, 2023',
          icon: Icons.description_outlined,
        ),
        MedicalRecordModel(
          title: 'Amoxicillin Refill',
          doctor: 'Pharmacy Central',
          date: 'Oct 12, 2023',
          icon: Icons.medication_outlined,
        ),
        MedicalRecordModel(
          title: 'Blood Test Results',
          doctor: 'LabCorp Diagnostics',
          date: 'Sep 28, 2023',
          icon: Icons.science_outlined,
        ),
        MedicalRecordModel(
          title: 'Dental Visit',
          doctor: 'Dr. Michael Lee',
          date: 'Sep 18, 2023',
          icon: Icons.medical_services_outlined,
        ),
      ];
      emit(MedicalLoaded(records));
    } catch (e) {
      emit(MedicalError(e.toString()));
    }
  }
}

////////////////////////////////////////////////////////////
/// PAGE (MedicalRecordsPage)
////////////////////////////////////////////////////////////
class MedicalRecordsPage extends StatelessWidget {
  const MedicalRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // توفير الـ Cubit للصفحة
    return BlocProvider(
      create: (context) => MedicalCubit()..getRecords(),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // مقاس ثابت
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- APP BAR ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'Medical Records',
                      style: TextStyle(
                        fontSize: 22, // مقاس ثابت
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_none),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // --- SEARCH ---
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search records...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- FILTERS ---
                SizedBox(
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      filterChip(title: 'All', isSelected: true),
                      filterChip(title: 'Prescriptions', isSelected: false),
                      filterChip(title: 'Lab Results', isSelected: false),
                      filterChip(title: 'Visits', isSelected: false),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                const Text(
                  'Recent Records',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),

                // --- LIST ---
                Expanded(
                  child: BlocBuilder<MedicalCubit, MedicalState>(
                    builder: (context, state) {
                      if (state is MedicalLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is MedicalLoaded) {
                        return ListView.separated(
                          itemCount: state.records.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            return RecordCard(record: state.records[index]);
                          },
                        );
                      }
                      if (state is MedicalError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterChip({required String title, required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// RECORD CARD Widget
////////////////////////////////////////////////////////////
class RecordCard extends StatelessWidget {
  final MedicalRecordModel record;
  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(record.icon, color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  record.doctor,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  record.date,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
