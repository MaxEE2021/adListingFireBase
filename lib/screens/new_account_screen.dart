
import 'package:classified_app/screens/validation_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';

class NewAccountScreen extends StatelessWidget {
  // const NewAccountScreen({Key? key}) : super(key: key);
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _numberCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();

  registation(){
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    auth.createUserWithEmailAndPassword(email: _emailCtrl.text, password: _pwdCtrl.text).then((res){
      firestore.collection('users').doc(res.user?.uid).set({
        "email"  : _emailCtrl.text,
        "name"   : _nameCtrl.text,
        "number" : _numberCtrl.text,
        "UID"    : res.user?.uid.toString(),
        "img"    : ""
      });
      print("Registration Succes");
    }).catchError((e){
      print(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 25,

      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.indigo,
              // height: size.height*0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
      
                  Container(
                    height: size.height *0.42,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/background.png") 
                      )
                    ),
                  ),
        
                  Container(
                    height: size.height*0.08,
                    child: Image.asset(
                      "assets/img/logo.png"
                    ),
                  ),
                  // Container(child: Image.asset("assets/img/logo.png"))
                  
                ],
              ),
            ),

            Container(
              // height: size.height *0.58,
              // color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomTextFieldWidget(
                      cstmController: _nameCtrl,                
                      customHintText: "Full Name",
                      textType: TextInputType.text,
                    ),
                    CustomTextFieldWidget(
                      cstmController: _emailCtrl,
                      customHintText: "Email Address",
                      textType: TextInputType.emailAddress,
                    ),
                    CustomTextFieldWidget(
                      cstmController: _numberCtrl,
                      customHintText: "Mobile Number",
                      textType: TextInputType.number,
                    ),
                    CustomTextFieldWidget(
                      cstmController: _pwdCtrl,
                      customHintText: "Password",
                      textType: TextInputType.text,
                      isPassword: true,
                    ),

                    CustomButtonWidget(
                      buttonText: "Register Now",
                      buttonFunction: (){
                        registation();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ValidationScreen()));
                      },
                    ),

                    TextButton(
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInScreen()));
                      }, 
                    )


                  ],
                ),
              ),
            )
         
          ],
        ),
      ),
    );
  }
}