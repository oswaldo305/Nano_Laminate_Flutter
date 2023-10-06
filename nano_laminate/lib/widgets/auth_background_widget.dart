import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [

            _PurpleBox(),

            _HeaderIcon(),

            child,

          ],
        ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only( top: 30 ),
        child: const Image(
          height: 110.0,
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}


class _PurpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _Bubble() ),
          Positioned(top: -40, left: -30, child: _Bubble() ),
          Positioned(top: -50, right: -20, child: _Bubble() ),
          Positioned(bottom: -50, left: 10, child: _Bubble() ),
          Positioned(bottom: 120, right: 20, child: _Bubble() ),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color.fromRGBO(150, 0, 19, 1),
        Colors.red[200]!
      ]
    )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}