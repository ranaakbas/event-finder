import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePageBackground extends StatelessWidget {
  final screenHeight;

  const ProfilePageBackground({Key? key, @required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: ClipPath(
        clipper: BottomShapeClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: screenHeight * 0.65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF70B0C5),
                Color(0xFF7ACE8C),
                Color(0xFFCBBC66),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 5),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white60, width: 15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF1B2677),
                        size: 65,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    '${FirebaseAuth.instance.currentUser?.email}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.85);
    Offset curveEndPoint = Offset(size.width, size.height * 0.85);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
