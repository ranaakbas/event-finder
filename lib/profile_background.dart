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
          color: Colors.amber,
          child: Stack(
            alignment: Alignment.center,
            children: [ Column( children:[
            SizedBox(height: 120,),
              Container(
                width: 180,
                height: 180,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(color: Colors.white.withOpacity(0.2), width: 5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white60, width: 15),
                  ),
                  child:
                    Icon(
                      Icons.person,
                      size: 65,
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Text(
                      'e-mail yazsın',
                      style: TextStyle(fontSize: 27, color: Colors.black),
                    ),],)
              
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
