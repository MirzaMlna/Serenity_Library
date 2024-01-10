import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/auth/services/login_or_register.dart';
import 'package:serenity/app/presentation/auth/services/login_success_view.dart';
import 'package:serenity/app/presentation/admin/views/main/admin_main_view.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? userEmail = snapshot.data?.email;
            if (userEmail == 'admin@gmail.com') {
              return const AdminMainView();
            } else {
              return const LoginSuccessView();
            }
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
