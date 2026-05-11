import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/doctor.dart';
import 'find_doctor_state.dart';

class FindDoctorCubit extends Cubit<FindDoctorState> {
  FindDoctorCubit() : super(FindDoctorInitial());

  static const List<Doctor> _source = [
    Doctor(
      id: 'doctor_1',
      name: 'Dr. Jane Smith',
      specialty: 'Cardiologist',
      clinicName: 'Heart Care Clinic',
      location: 'Manhattan, New York',
      rating: 4.8,
      reviews: 120,
      experience: '10 years experience',
      yearsOfExperience: 10,
      patientsCount: '500+',
      price: 120,
      imagePath: 'assets/image7.jpg',
      bio:
          'Dr. Jane Smith is a board-certified cardiologist with over 10 years of experience in treating complex heart conditions. She specializes in preventive care and advanced diagnostics.',
      isLiked: false,
      isOnline: true,
      distanceKm: 2.4,
    ),
    Doctor(
      id: 'doctor_2',
      name: 'Dr. Michael Chen',
      specialty: 'Dermatologist',
      clinicName: 'Skin Care Center',
      location: 'Brooklyn, New York',
      rating: 4.9,
      reviews: 85,
      experience: '7 years experience',
      yearsOfExperience: 7,
      patientsCount: '350+',
      price: 95,
      imagePath: 'assets/image3.jpg',
      bio:
          'Dr. Michael Chen is an experienced dermatologist focused on skin health, cosmetic dermatology, and long-term treatment plans.',
      isLiked: false,
      isOnline: true,
      distanceKm: 3.1,
    ),
    Doctor(
      id: 'doctor_3',
      name: 'Dr. Sarah Wilson',
      specialty: 'Pediatrician',
      clinicName: 'Kids Health Clinic',
      location: 'Manhattan, New York',
      rating: 5.0,
      reviews: 210,
      experience: '12 years experience',
      yearsOfExperience: 12,
      patientsCount: '800+',
      price: 110,
      imagePath: 'assets/image5.jpg',
      bio:
          'Dr. Sarah Wilson provides comprehensive pediatric care with a focus on preventive medicine, growth follow-up, and family-centered care.',
      isLiked: true,
      isOnline: true,
      distanceKm: 1.8,
    ),
    Doctor(
      id: 'doctor_4',
      name: 'Dr. James Robert',
      specialty: 'Neurologist',
      clinicName: 'Neuro Care Clinic',
      location: 'Queens, New York',
      rating: 4.7,
      reviews: 94,
      experience: '15 years experience',
      yearsOfExperience: 15,
      patientsCount: '650+',
      price: 150,
      imagePath: 'assets/image3.jpg',
      bio:
          'Dr. James Robert is a neurologist specialized in headache disorders, nerve conditions, and neurological evaluations.',
      isLiked: false,
      isOnline: false,
      distanceKm: 5.6,
    ),
  ];

  void loadDoctors() {
    emit(FindDoctorLoading());

    const selectedFilter = 'Rating';
    final filteredDoctors = _applySearchAndFilter(
      doctors: _source,
      query: '',
      filter: selectedFilter,
    );

    emit(
      FindDoctorLoaded(
        allDoctors: _source,
        filteredDoctors: filteredDoctors,
        selectedFilter: selectedFilter,
      ),
    );
  }

  void toggleLike(String doctorId) {
    final currentState = state;
    if (currentState is! FindDoctorLoaded) return;

    final updatedAllDoctors = currentState.allDoctors.map((doctor) {
      if (doctor.id == doctorId) {
        return doctor.copyWith(isLiked: !doctor.isLiked);
      }
      return doctor;
    }).toList();

    final filteredDoctors = _applySearchAndFilter(
      doctors: updatedAllDoctors,
      query: currentState.searchQuery,
      filter: currentState.selectedFilter,
    );

    emit(
      currentState.copyWith(
        allDoctors: updatedAllDoctors,
        filteredDoctors: filteredDoctors,
      ),
    );
  }

  void applyFilter(String filter) {
    final currentState = state;
    if (currentState is! FindDoctorLoaded) return;

    final filteredDoctors = _applySearchAndFilter(
      doctors: currentState.allDoctors,
      query: currentState.searchQuery,
      filter: filter,
    );

    emit(
      currentState.copyWith(
        filteredDoctors: filteredDoctors,
        selectedFilter: filter,
      ),
    );
  }

  void search(String query) {
    final currentState = state;
    if (currentState is! FindDoctorLoaded) return;

    final filteredDoctors = _applySearchAndFilter(
      doctors: currentState.allDoctors,
      query: query,
      filter: currentState.selectedFilter,
    );

    emit(
      currentState.copyWith(
        filteredDoctors: filteredDoctors,
        searchQuery: query,
      ),
    );
  }

  static List<Doctor> _applySearchAndFilter({
    required List<Doctor> doctors,
    required String query,
    required String filter,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    final searchedDoctors = doctors.where((doctor) {
      if (normalizedQuery.isEmpty) return true;

      return doctor.name.toLowerCase().contains(normalizedQuery) ||
          doctor.specialty.toLowerCase().contains(normalizedQuery) ||
          doctor.clinicName.toLowerCase().contains(normalizedQuery);
    }).toList();

    switch (filter) {
      case 'Rating':
        searchedDoctors.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Price':
        searchedDoctors.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Availability':
        searchedDoctors.sort((a, b) {
          if (a.isOnline == b.isOnline) return 0;
          return a.isOnline ? -1 : 1;
        });
        break;
      case 'Distance':
        searchedDoctors.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
    }

    return searchedDoctors;
  }
}