import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/utlis/theme.dart';
import 'package:serenity/app/presentation/auth/services/auth.dart';
import 'package:serenity/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: serenityTheme,
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset(
              "assets/images/serenity_logo.png",
            ),
            nextScreen: const Auth(),
            splashTransition: SplashTransition.fadeTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: serenityBlack));
  }
}
