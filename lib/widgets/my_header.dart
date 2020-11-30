
import 'package:covid/constant.dart';
import 'package:covid/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyHeader extends StatefulWidget {
  final String image;
  final String textTitle;
  final String textTop;
  final String textBottom;
  final double offset;
  const MyHeader(
      {Key key, this.image, this.textTitle, this.textTop, this.textBottom, this.offset})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, top: 40, right: 20),
        height: size.height*0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    child: SvgPicture.asset(
                      widget.image,
                      width: size.width*0.45,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 10 - widget.offset / 2,
                    left: size.width*0.28,
                    child: Text(
                      "${widget.textTitle} \n ${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(), // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}