import 'dart:ffi';
import 'dart:math';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:akbas_bas_eventfinderapp/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _passwordVisible = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordAgain = TextEditingController();

// try {
//   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: emailAddress,
//     password: password,
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);
// }
  void SaveUserIn() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
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
              buildBackHome(
                  backHome: Icons.arrow_back,
                  widget: HomePage(),
                  context: context),
              Container(
                margin: EdgeInsets.only(top: 130, bottom: 50),
                child: Center(
                  child: Text(
                    "PROFİL BURA",
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
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                child: TextFormField(
                  controller: email,
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
                margin:
                    EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                child: TextFormField(
                  controller: password,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.key_rounded,
                      color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     _passwordVisible = !_passwordVisible;
                      //   });
                      // },
                      child: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Password',
                  ),
                  style: TextStyle(color: Color(0xFF0A1034), letterSpacing: 4),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin:
                    EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                child: TextFormField(
                  controller: passwordAgain,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.key_rounded,
                      color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     _passwordVisible = !_passwordVisible;
                      //   });
                      // },
                      child: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Password again',
                  ),
                  style: TextStyle(color: Color(0xFF0A1034), letterSpacing: 4),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                  onTap: () {
                    SaveUserIn();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 105),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFDE6EAE), Color(0xFFEAB06A)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
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
        Navigator.pop(context);
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
      ));
}
