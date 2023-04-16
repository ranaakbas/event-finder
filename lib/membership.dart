import 'dart:ffi';
import 'dart:math';

import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:akbas_bas_eventfinderapp/signin.dart';
import 'package:flutterfire_ui/auth.dart';

class MembershipPage extends StatefulWidget {
   MembershipPage({Key? key}) : super(key: key);
   @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {

  bool _passwordVisible = false;


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
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                child: TextFormField(
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
                  style: TextStyle(color: Color(0xFF0A1034), letterSpacing: 4),
                ),
              ),
              Container(
  margin: EdgeInsets.symmetric(vertical: 10),
  child: InkWell(
    onTap: () {},
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

              InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 90),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4F6CC4), Color(0xFF63AA65)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                  SizedBox(height:35),
              InkWell(
                
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SignInPage();
    }));
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
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
                    
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
      ));
}

