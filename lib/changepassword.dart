import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/profile.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                buildBackHome(
                    backHome: Icons.arrow_back,
                    widget: ProfilePage(),
                    context: context),
                Container(
                  alignment: Alignment.center,
                  height: 250.0,
                ),
                SizedBox(
                  height: 35.0,
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
                      prefixIcon: Icon(Icons.password),
                      hintText: 'New Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    backgroundColor: Color(0xFF70B0C5),
                  ),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
