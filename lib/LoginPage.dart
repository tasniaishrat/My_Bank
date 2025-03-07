import 'package:flutter/material.dart';
import 'package:my_bank/ForgotPassword.dart';

import 'HomePage.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEnglish = true; // Language toggle state
  bool _isPasswordVisible = false;


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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bank_logo.png',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'Welcome To' : 'স্বাগতম',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      isEnglish ? 'My Bank' : 'মাই ব্যাংক',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: isEnglish ? 'UserID' : 'ব্যবহারকারীর আইডি',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: isEnglish ? 'Password' : 'পাসওয়ার্ড',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                      // Implement login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F2F9B),
                      foregroundColor: Colors.white,
                      minimumSize: Size(260, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      isEnglish ? 'Login' : 'লগইন',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                   // Space between button and image
                  Image.asset(
                    'assets/biometric.png',
                    // Path to your image asset
                    width: 50.0, // Set the width of the image
                    height: 50.0, // Set the height of the image
                  ),
                ],
              ),

              // Forgot Password? Text
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    );
                  },
                  child: Text(
                    isEnglish ? 'Forgot Password?' : 'পাসওয়ার্ড ভুলে গেছেন?',
                    style: TextStyle(
                      color: Color(0xFF1F2F9B),
                      fontSize: 16,

                    ),
                  ),
                ),
              ),

              SizedBox(height: 40), // Extra space before bottom links

              // FAQ & Language Button in the same row
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Implement FAQ page navigation
                      },
                      child: Text(
                        isEnglish ? 'FAQ' : 'প্রশ্নোত্তর',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
          SizedBox(width: 20), // Space between FAQ and language button
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  isEnglish ? 'বাংলা' : 'English',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                        ),
                      ),
                      ),
                    ),
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
