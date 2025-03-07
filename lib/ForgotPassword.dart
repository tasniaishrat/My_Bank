import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool isOtpSent = false;
  bool isOtpVerified = false;
  int _otpTimer = 60;
  Timer? _timer;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startOtpTimer() {
    _otpTimer = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_otpTimer > 0) {
        setState(() {
          _otpTimer--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resetPassword() {
    setState(() {
      isOtpSent = true;
      _startOtpTimer();
    });
  }

  void _verifyOtp() {
    if (_otpController.text == "123456") {
      setState(() {
        isOtpVerified = true;
      });
    }
  }

  void _submitNewPassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      setState(() {
        isOtpSent = false;
        isOtpVerified = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Password Changed Successfully'),
          content: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50.0,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print("Passwords do not match!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/bank_logo.png',
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Make the page scrollable
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isOtpSent)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter your email address',
                    ),
                  ),
                  SizedBox(height: 17),
                  ElevatedButton(
                    onPressed: _resetPassword ,
                      // Implement login logic here


                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF000000),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'Send OTP',
                      style: TextStyle(fontSize: 18),

                    ),
                  ),


                ],
              )
            else if (!isOtpVerified)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('$_otpTimer seconds remaining'),
                  SizedBox(height: 20),
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                    ),
                  ),
                  SizedBox(height: 17),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF000000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(fontSize: 18),

                      ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
                  ElevatedButton(
                    onPressed: _submitNewPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF000000),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'Reset Password ',
                      style: TextStyle(fontSize: 18),

                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

