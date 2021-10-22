import 'package:classified_app/screens/home_screen.dart';
import 'package:classified_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ValidationScreen extends StatefulWidget {
  ValidationScreen({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    validateAuth();
  }

  validateAuth(){
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((user) { 
      if(user == null){
        setState(() {
          _isLoggedIn = false;
        });
      }
      else{
        setState(() {
          _isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn? HomeScreen() : LogInScreen();
  }
}