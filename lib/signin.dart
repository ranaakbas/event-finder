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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _passwordVisible = false;
  bool _passwordVisibleAgain = false;
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

  void SaveUserIn(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // Kullanıcı başarılı bir şekilde oturum açtı, anasayfaya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Hata oluştu, hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt oluşturma başarısız oldu")),
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
                                    "Sign Up",
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
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 3, bottom: 3),
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
                                    hintText: 'Password',
                                  ),
                                  style: TextStyle(
                                      color: Color(0xFF0A1034),
                                      letterSpacing: 4),
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
                                  controller: passwordAgain,
                                  obscureText: !_passwordVisibleAgain,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.key_rounded,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _passwordVisibleAgain =
                                              !_passwordVisibleAgain;
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisibleAgain
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: 'Password again',
                                  ),
                                  style: TextStyle(
                                      color: Color(0xFF0A1034),
                                      letterSpacing: 4),
                                ),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  SaveUserIn(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 105),
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF70B0C5),
                                        Color(0xFF7ACE8C),
                                        Color(0xFFCBBC66)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
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
    ),
  );
}
