import 'package:classified_app/screens/login_screen.dart';
import 'package:classified_app/screens/validation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValidationScreen(),
      // home: LogInScreen(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
