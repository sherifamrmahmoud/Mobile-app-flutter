import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart'; 
import 'firebase_options.dart'; 

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupGetIt();

  await ScreenUtil.ensureScreenSize();

  runApp(const MediCallApp());
}

class MediCallApp extends StatelessWidget {
  const MediCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
     
        return MaterialApp.router(
          routerConfig: appRouter, 
          title: 'MEDI CALL',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue, 
            scaffoldBackgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}