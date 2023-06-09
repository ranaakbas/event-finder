import 'dart:ffi';
import 'dart:math';

import 'package:akbas_bas_eventfinderapp/auth.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:akbas_bas_eventfinderapp/signin.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:akbas_bas_eventfinderapp/forgotpassword.dart';

class MembershipPage extends StatefulWidget {
  MembershipPage({super.key});

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  bool _passwordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  // void signUserIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  // }
  void signUserIn(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Kullanıcı başarılı bir şekilde oturum açtı, anasayfaya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Hata oluştu, hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Oturum açma başarısız oldu")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF70B0C5),
                                      Color(0xFF7ACE8C),
                                      Color(0xFFCBBC66),
                                    ],
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 130, bottom: 50),
                                child: Center(
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Color(0xFF0A1034),
                                      fontSize: 37,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 3, bottom: 3),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                    ),
                                    hintText: 'E-Mail',
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF0A1034),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 3, bottom: 3),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.key_rounded,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Color(0xFF0A1034),
                                      letterSpacing: 4),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  signUserIn(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 90),
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF70B0C5),
                                        Color(0xFF7ACE8C),
                                        Color(0xFFCBBC66),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage(context)));
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xFF4F6CC4),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInPage()));
                                  },
                                  child: Text(
                                    "Create Account.",
                                    style: TextStyle(
                                      color: Color(0xFF4F6CC4),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBackHome(
    {required IconData backHome,
    required Widget widget,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Column(
      children: [
        SizedBox(height: 29),
        Icon(
          backHome,
          color: Colors.black,
          size: 50,
        ),
      ],
    ),
  );
}
