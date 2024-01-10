import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/widgets/buttons.dart';
import 'package:serenity/app/utlis/input_decoration.dart';
import 'package:serenity/app/widgets/text_style.dart';

class SignInView extends StatefulWidget {
  final Function()? moveToSignUp;
  const SignInView({super.key, this.moveToSignUp});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void userSignIn() async {
    //loading display
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: const CircularProgressIndicator());
    //     });

    // Validasi format email
    String email = emailController.text;
    if (!isValidEmail(email)) {
      showMessage('Format email tidak valid');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwordController.text,
      );
      showMessage('Berhasil Masuk Sebagai ${emailController.text}');
    } on FirebaseAuthException catch (e) {
      showMessage('E-mail atau Password Salah');
      // ignore: avoid_print
      print(e);
    }
  }

  //email format validator
  bool isValidEmail(String email) {
    String emailRegex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

// error message
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: serenityPrimary,
            title: Text(
              message,
              textAlign: TextAlign.center,
              style: serenityTitle,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/serenity_logo.png",
                  width: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Silahkan Login ke Akun Anda',
                  style: serenityHeader,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  children: [
//email input
                    TextFormField(
                        controller: emailController,
                        decoration:
                            customInputDecoration('E-mail', Icons.email)),
                    const SizedBox(
                      height: 20,
                    ),
//password input
                    TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            customInputDecoration('Password', Icons.lock)),
                    const SizedBox(
                      height: 20,
                    ),

                    CircleButton(
                        color: serenityPrimary,
                        shadowColor: serenitySecondary,
                        text: 'Masuk',
                        onTap: userSignIn)
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum Punya Akun? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: widget.moveToSignUp,
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                            color: serenitySecondary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
