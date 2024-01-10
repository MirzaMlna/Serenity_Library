import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/user/views/main/main_view.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/widgets/buttons.dart';
import 'package:serenity/app/widgets/text_style.dart';

class LoginSuccessView extends StatelessWidget {
  const LoginSuccessView({super.key});
  void userLogOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/serenity_tag.png",
                width: 300,
              ),
              Image.asset(
                "assets/images/login_background.png",
                width: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              RectangleButton(
                  color: serenityPrimary,
                  shadowColor: serenitySecondary,
                  text: 'Masuk',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const MainView();
                    })));
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ingin Keluar? '),
                  GestureDetector(
                    onTap: userLogOut,
                    child: Text(
                      'Keluar',
                      style: serenityTitle.copyWith(color: serenitySecondary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
