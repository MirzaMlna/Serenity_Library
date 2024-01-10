import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/auth/views/sign_in_view.dart';
import 'package:serenity/app/presentation/auth/views/sign_up_view.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//initially show login page
  bool showSignInView = true;
//toogle between login and register page
  void tooglePages() {
    setState(() {
      showSignInView = !showSignInView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInView) {
      return SignInView(
        moveToSignUp: tooglePages,
      );
    } else {
      return const SignUpView();
    }
  }
}
