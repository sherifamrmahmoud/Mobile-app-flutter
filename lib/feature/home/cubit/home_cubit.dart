import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/appointment.dart';
import '../../../core/models/specialist.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadHome() {
    emit(HomeLoading());

    // TODO: استبدل بـ API أو Hive حقيقي
    emit(HomeLoaded(
      userName: 'Alex Harrison',
      greetingMessage: 'Good Morning',
      upcomingAppointment: Appointment(
        doctorName: 'Dr. Sarah Jenkins',
        specialty: 'General Practitioner',
        dateTime: 'Today, 10:30 AM',
        imagePath: 'assets/image2.jpg',
      ),
      topSpecialists: [
        Specialist(
          name: 'Dr. James Wilson',
          specialty: 'Cardiologist',
          rating: 4.9,
          imagePath: 'assets/image3.jpg',
        ),
        Specialist(
          name: 'Dr. Maria Garcia',
          specialty: 'Pediatrician',
          rating: 4.8,
          imagePath: 'assets/image2.jpg',
        ),
        Specialist(
          name: 'Dr. Ahmed Karim',
          specialty: 'Neurologist',
          rating: 4.7,
          imagePath: 'assets/image4.jpg',
        ),
      ],
    ));
  }
}
