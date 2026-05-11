import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/doctor.dart';
import 'doctor_booking_state.dart';

class DoctorBookingCubit extends Cubit<DoctorBookingState> {
  DoctorBookingCubit() : super(_initialState());

  static DoctorBookingState _initialState() {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day);

    return DoctorBookingState(
      availableDates: List.generate(
        5,
        (index) => startDate.add(Duration(days: index)),
      ),
      morningSlots: const [
        '09:00 AM',
        '09:30 AM',
        '10:00 AM',
        '10:30 AM',
        '11:00 AM',
        '11:30 AM',
      ],
      afternoonSlots: const [
        '01:00 PM',
        '02:30 PM',
        '04:00 PM',
      ],
      selectedDate: startDate,
    );
  }

  void selectDate(DateTime date) {
    emit(
      state.copyWith(
        selectedDate: date,
        clearSelectedTime: true,
        isSuccess: false,
        clearError: true,
      ),
    );
  }

  void selectTime(String time) {
    emit(
      state.copyWith(
        selectedTime: time,
        isSuccess: false,
        clearError: true,
      ),
    );
  }

  Future<void> confirmAppointment({
    required Doctor doctor,
  }) async {
    if (state.selectedTime == null) {
      emit(state.copyWith(errorMessage: 'Please select appointment time'));
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        isSuccess: false,
        clearError: true,
      ),
    );

    // TODO: Replace with Firestore/API booking request.
    await Future.delayed(const Duration(milliseconds: 700));

    emit(
      state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        clearError: true,
      ),
    );
  }
}