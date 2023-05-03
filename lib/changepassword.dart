import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(BuildContext context, {super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgetPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: 'New Password',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  var password = forgetPasswordController.text.trim();
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    try {
                      await user.updatePassword(password);
                      print("Password Updated!");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Şifre güncellendi")),
                      );
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MembershipPage()),
                      // );
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Şifre güncelleme başarısız oldu")),
                      );
                    }
                  }
                },
                child: Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
