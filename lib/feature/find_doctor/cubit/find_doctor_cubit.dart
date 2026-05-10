import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/doctor.dart';
import 'find_doctor_state.dart';

class FindDoctorCubit extends Cubit<FindDoctorState> {
  FindDoctorCubit() : super(FindDoctorInitial());

  static final List<Doctor> _source = [
    const Doctor(
      name: 'Dr. Jane Smith',
      specialty: 'Cardiologist',
      rating: 4.8,
      reviews: 120,
      experience: '10 years experience',
      price: 120,
      imagePath: 'assets/image7.jpg',
      isLiked: false,
    ),
    const Doctor(
      name: 'Dr. Michael Chen',
      specialty: 'Dermatologist',
      rating: 4.9,
      reviews: 85,
      experience: '7 years experience',
      price: 95,
      imagePath: 'assets/image3.jpg',
      isLiked: false,
    ),
    const Doctor(
      name: 'Dr. Sarah Wilson',
      specialty: 'Pediatrician',
      rating: 5.0,
      reviews: 210,
      experience: '12 years experience',
      price: 110,
      imagePath: 'assets/image5.jpg',
      isLiked: true,
    ),
    const Doctor(
      name: 'Dr. James Robert',
      specialty: 'Neurologist',
      rating: 4.7,
      reviews: 94,
      experience: '15 years experience',
      price: 150,
      imagePath: 'assets/image3.jpg',
      isLiked: false,
    ),
  ];

  void loadDoctors() {
    emit(FindDoctorLoading());
    emit(FindDoctorLoaded(
      allDoctors: _source,
      filteredDoctors: _source,
      selectedFilter: 'Rating',
    ));
  }

  void toggleLike(int index) {
    final s = state;
    if (s is! FindDoctorLoaded) return;
    final updated = List<Doctor>.from(s.filteredDoctors);
    updated[index] = updated[index].copyWith(isLiked: !updated[index].isLiked);
    emit(s.copyWith(filteredDoctors: updated));
  }

  void applyFilter(String filter) {
    final s = state;
    if (s is! FindDoctorLoaded) return;
    final sorted = List<Doctor>.from(s.allDoctors);
    switch (filter) {
      case 'Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Price':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
    emit(s.copyWith(filteredDoctors: sorted, selectedFilter: filter));
  }

  void search(String query) {
    final s = state;
    if (s is! FindDoctorLoaded) return;
    if (query.isEmpty) {
      emit(s.copyWith(filteredDoctors: s.allDoctors));
      return;
    }
    final filtered = s.allDoctors.where((d) {
      return d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.specialty.toLowerCase().contains(query.toLowerCase());
    }).toList();
    emit(s.copyWith(filteredDoctors: filtered));
  }
}
