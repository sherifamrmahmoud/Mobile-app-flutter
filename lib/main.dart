import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/login/login_screen.dart';
import 'package:nti5/auth/signup/signup_screen.dart';
import 'package:nti5/core/data_source/firebase_data_source.dart';
import 'package:nti5/features/Home/home_screen.dart';
import 'package:nti5/features/OnboardingScreen/OnboardingScreen.dart';

import 'package:nti5/features/Splash%20Screen/splash_screen.dart';
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
        '/home': (context) => HomeScreen(),
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
