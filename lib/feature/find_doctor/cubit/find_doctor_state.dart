import '../../../core/models/doctor.dart';

abstract class FindDoctorState {}

class FindDoctorInitial extends FindDoctorState {}

class FindDoctorLoading extends FindDoctorState {}

class FindDoctorLoaded extends FindDoctorState {
  final List<Doctor> allDoctors;
  final List<Doctor> filteredDoctors;
  final String selectedFilter;

  FindDoctorLoaded({
    required this.allDoctors,
    required this.filteredDoctors,
    required this.selectedFilter,
  });

  FindDoctorLoaded copyWith({
    List<Doctor>? allDoctors,
    List<Doctor>? filteredDoctors,
    String? selectedFilter,
  }) =>
      FindDoctorLoaded(
        allDoctors: allDoctors ?? this.allDoctors,
        filteredDoctors: filteredDoctors ?? this.filteredDoctors,
        selectedFilter: selectedFilter ?? this.selectedFilter,
      );
}

class FindDoctorError extends FindDoctorState {
  final String message;
  FindDoctorError(this.message);
}
