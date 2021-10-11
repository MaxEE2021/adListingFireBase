import 'package:classified_app/screens/home_screen.dart';
import 'package:classified_app/screens/new_account_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

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
              height: size.height *0.58,
              // color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomTextFieldWidget(
                      customHintText: "Email",
                      textType: TextInputType.emailAddress,
                    ),
                    CustomTextFieldWidget(
                      customHintText: "Password",
                      textType: TextInputType.text,
                      isPassword: true,
                    ),

                    CustomButtonWidget(
                      buttonText: "Login",
                      buttonFunction: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                    ),

                    TextButton(
                      child: Text(
                        "Don't have any account?",
                        style: TextStyle(
                          color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewAccountScreen()));
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