// ignore_for_file: unused_local_variable, avoid_print

import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage(BuildContext context, {super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBackHome(
                      backHome: Icons.arrow_back,
                      widget: MembershipPage(),
                      context: context),
                  Container(
                    alignment: Alignment.center,
                    height: 250.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                    child: TextFormField(
                      controller: forgetPasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        var forgotEmail = forgetPasswordController.text.trim();

                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgotEmail)
                              .then((value) => {
                                    print("Email Sent!"),
                                  });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MembershipPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          print("Error $e");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        backgroundColor: Color(0xFF70B0C5),
                      ),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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