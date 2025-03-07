import 'package:flutter/material.dart';
import 'dart:async';
import 'LoginPage.dart'; // Importing the login page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    // Logo animation: Moves from top to center
    _logoAnimation = Tween<double>(begin: -150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Title animation: Moves from below the logo to just beneath it
    _titleAnimation = Tween<double>(begin: 150, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Navigate to the login page after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE9F8FF),
            Color(0xFF90B2D8),
            Color(0xFFC1E3FF),


          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Ensures Scaffold background is transparent
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _logoAnimation.value),
                    child: Image.asset(
                      'assets/bank_logo.png', // Your bank logo
                      width: MediaQuery.of(context).size.width * 0.8, // 60% of screen width
                      height: MediaQuery.of(context).size.width * 0.8, // 60% of screen width
                    ),
                  );
                },
              ),
              SizedBox(height: 20), // Space between logo and title
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _titleAnimation.value),
                    child: Text(
                      "Where Trust Meets Tradition",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
