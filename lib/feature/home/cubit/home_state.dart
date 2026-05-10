import '../../../core/models/appointment.dart';
import '../../../core/models/specialist.dart';


abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String userName;
  final String greetingMessage;
  final Appointment upcomingAppointment;
  final List<Specialist> topSpecialists;

  HomeLoaded({
    required this.userName,
    required this.greetingMessage,
    required this.upcomingAppointment,
    required this.topSpecialists,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
