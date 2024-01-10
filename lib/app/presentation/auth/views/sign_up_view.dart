import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/app/presentation/auth/views/sign_in_view.dart';
import 'package:serenity/app/utlis/color_pallete.dart';
import 'package:serenity/app/widgets/buttons.dart';
import 'package:serenity/app/utlis/input_decoration.dart';
import 'package:serenity/app/widgets/text_style.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void userSignUp() async {
    //loading display
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           CircularProgressIndicator(),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             'Tekan Dimana Saja',
    //             style: serenityTitle,
    //           )
    //         ],
    //       );
    //     });

    // Validasi format email

    if (!isValidEmail(emailController.text)) {
      showMessage('Format email tidak valid');
      return;
    }

    try {
      //checking password length
      if (passwordController.text.length < 6) {
        showMessage('Password Minimal 6 Huruf');
      } //checking password and confirm password is same
      else if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        showMessage('Berhasil Masuk Sebagai ${emailController.text}');
      } else {
        showMessage('Password Tidak Sama');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // when the email is already in use
        showMessage('Email Sudah Terdaftar, Harap Gunakan Email Lain !');
      } else {
        showMessage(e.code);
      }
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
            title: Text(message,
                textAlign: TextAlign.center, style: serenityTitle),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/serenity_logo.png",
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Silahkan Isi Form Di Bawah',
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
                    TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: customInputDecoration(
                            'Ulang Password', Icons.lock)),
                    const SizedBox(
                      height: 20,
                    ),

                    CircleButton(
                        color: serenityPrimary,
                        shadowColor: serenitySecondary,
                        text: 'Lanjut',
                        onTap: userSignUp)
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah Punya Akun? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const SignInView())));
                      },
                      child: const Text(
                        'Masuk',
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
