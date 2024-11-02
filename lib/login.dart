import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_app/lottery_app/layout_lotto.dart';
import 'package:login_app/register.dart';
import 'package:login_app/widget/my_container.dart';
import 'package:login_app/widget/my_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    // final double currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    // Text(
                    //   "Current width: ${currentWidth.toString()}",
                    //   style: const TextStyle(
                    //     fontSize: 25,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Image.asset(
                      "images/codingchef.png",
                      width: 150,
                      height: 150,
                    )
                        .animate()
                        .fade()
                        .slideY(begin: -3, end: 0)
                        .animate(onPlay: (controller) => controller.repeat())
                        .shake(hz: 4, curve: Curves.ease, duration: 1800.ms),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Welcom back!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        .animate()
                        .fade(delay: 500.ms)
                        .slideX(
                          begin: -2,
                          end: 0,
                        )
                        .tint(
                          color: Colors.purple,
                          delay: 1000.ms,
                        ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ).animate().fade(delay: 500.ms).slideX(
                          begin: 2,
                          end: 0,
                        ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextfield(
                      emailType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ).animate().fade().slideX(
                          begin: -3,
                          end: 0,
                          duration: 900.ms,
                        ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextfield(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ).animate().fade().slideX(
                          begin: 3,
                          end: 0,
                          duration: 900.ms,
                        ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          if (newUser.user != null) {
                            setState(() {
                              showSpinner = false;
                            });
                            if (!context.mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LayoutLotto()));
                            emailController.clear();
                            passwordController.clear();
                          }
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          print(e);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Something wrong with a sign up process!"),
                            backgroundColor: Colors.blue,
                          ));
                        }
                      },
                      child: MyContainer(
                        width: 120,
                        height: 50,
                        bgcolor: Colors.orange[300],
                        radius: 20,
                        icon: const Icon(Icons.arrow_forward),
                      ).animate().fade(delay: 900.ms),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(color: Colors.grey[700]),
                        ).animate().fade().slideX(
                              begin: -3,
                              end: 0,
                              delay: 300.ms,
                            ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ).animate().fade().slideX(
                                begin: 3,
                                end: 0,
                                delay: 300.ms,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Powered by CodingChef",
                              style: TextStyle(fontSize: 11),
                            ).animate().fade().slideX(
                                  begin: -3,
                                  end: 0,
                                  delay: 300.ms,
                                )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyContainer(
                          width: 50,
                          height: 50,
                          bgcolor: Colors.grey[200],
                          radius: 16,
                          imagePath: "images/codingchef3.png",
                        )
                            .animate()
                            .fade()
                            .slideY(begin: -3, end: 0)
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(delay: 1000.ms, duration: 1800.ms),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          if (showSpinner)
            const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ]),
      ),
    );
  }
}
