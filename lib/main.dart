import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/login/login_screen.dart';
import 'package:nti5/auth/signup/signup_screen.dart';
import 'package:nti5/core/data_source/firebase_data_source.dart';
import 'package:nti5/features/Home/cubit/home_cubit.dart';

import 'package:nti5/features/Home/screens/home_screen.dart';
import 'package:nti5/features/OnboardingScreen/OnboardingScreen.dart';

import 'package:nti5/features/Splash%20Screen/splash_screen.dart';
import 'package:nti5/features/My%20Appointments/appointments_screen.dart';
import 'package:nti5/features/doctor_diagnoses/diagnosis_summary_screen.dart';
import 'package:nti5/features/find_doctor/cubit/find_doctor_cubit.dart';
import 'package:nti5/features/find_doctor/screens/find_doctor_screen.dart';
import 'package:nti5/features/medical_records/medical_records.dart';
import 'package:nti5/features/profile/ui/profile_screen.dart';
// import 'package:nti5/features/profile/ui/widgets/summary_section.dart';
import 'package:nti5/features/summary/summary_diagnosis.dart';
import 'package:nti5/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/onboarding': (context) => Onboardingscreen(),

        '/signup': (context) => BlocProvider(
          create: (context) => AuthCubit(FirebaseDataSource()),
          child: SignupScreen(),
        ),

        '/login': (context) => BlocProvider(
          create: (context) => AuthCubit(FirebaseDataSource()),
          child: LoginScreen(),
        ),

        '/home': (context) => BlocProvider(
          create: (_) => HomeCubit()..loadHome(),

          child: HomeScreen(),
        ),
        '/find': (context) => BlocProvider(
          create: (_) => FindDoctorCubit()..loadDoctors(),

          child: FindDoctorScreen(),
        ),

        '/appointment': (context) => AppointmentsScreen(),
        '/diagnosis': (context) => DiagnosisSummaryScreen(),

        '/ProfileScreen': (context) => ProfileScreen(),
   
        '/sumarry': (context) => SummaryDiagnosis_Screen(),

        '/medicale_record': (context) => MedicalRecordsPage(),
      },
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
