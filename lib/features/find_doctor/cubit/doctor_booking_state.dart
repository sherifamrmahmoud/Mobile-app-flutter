class DoctorBookingState {
  final List<DateTime> availableDates;
  final List<String> morningSlots;
  final List<String> afternoonSlots;
  final DateTime selectedDate;
  final String? selectedTime;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const DoctorBookingState({
    required this.availableDates,
    required this.morningSlots,
    required this.afternoonSlots,
    required this.selectedDate,
    this.selectedTime,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get canConfirm => selectedTime != null && !isSubmitting;

  DoctorBookingState copyWith({
    List<DateTime>? availableDates,
    List<String>? morningSlots,
    List<String>? afternoonSlots,
    DateTime? selectedDate,
    String? selectedTime,
    bool clearSelectedTime = false,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DoctorBookingState(
      availableDates: availableDates ?? this.availableDates,
      morningSlots: morningSlots ?? this.morningSlots,
      afternoonSlots: afternoonSlots ?? this.afternoonSlots,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime:
          clearSelectedTime ? null : selectedTime ?? this.selectedTime,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}