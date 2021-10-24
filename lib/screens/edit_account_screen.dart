import 'dart:io';
import 'dart:math';

import 'package:classified_app/screens/login_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountScreen extends StatefulWidget {
  // EditAccountScreen({Key? key}) : super(key: key);
  final String imgProfFirebse;
  const EditAccountScreen ({
    this.imgProfFirebse="",
  });

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _numberCtrl = TextEditingController();
  String imagen = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  logout(){
    FirebaseAuth.instance.signOut().then((value){
    }).catchError((e){
      print(e);
    });
  }

  updateProfile(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "email"  : _emailCtrl.text,
      "name"   : _nameCtrl.text,
      "number" : _numberCtrl.text,
      "img"    : imagen
    });
  }
  
  getUserData(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((resp){
      _nameCtrl.text = resp["name"];
      _emailCtrl.text = resp["email"];
      _numberCtrl.text = resp["number"];
    });
  }

  uploadImg() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.isNotEmpty) {
      File image = File(pickedFile.path);
      var rng = Random();
      FirebaseStorage.instance
          .ref()
          .child("users")
          .child(rng.nextInt(10000).toString())
          .putFile(image)
          .then((res) {
        res.ref.getDownloadURL().then((url) {
          setState(() {
            imagen = url;
          });
        });
      }).catchError((e) {
        print(e.toString());
      });
    } else {
      print('Select photos');
    }
  }
  
  String image = "https://freesvg.org/img/abstract-user-flat-4.png";
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: InkWell(
                    onTap: uploadImg,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.imgProfFirebse == "" ?  imagen == "" ? image: imagen : widget.imgProfFirebse),
                      // backgroundImage: NetworkImage(widget.imgProfFirebse == "" ?  image : widget.imgProfFirebse ),
                      radius: size.height*0.08,
                    ),
                  ),
                ),
      
                CustomTextFieldWidget(
                  cstmController:_nameCtrl ,
                  textType: TextInputType.text,
                  customHintText: "Full Name",
                ),
                CustomTextFieldWidget(
                  cstmController: _emailCtrl,
                  textType: TextInputType.emailAddress,
                  customHintText: "Email",
                  readOnly: true,
                ),
                CustomTextFieldWidget(
                  cstmController: _numberCtrl,
                  textType: TextInputType.number,
                  customHintText: "Phone Number",
                ),
      
                CustomButtonWidget(
                  buttonText: "Update Profile",
                  buttonFunction: (){
                    updateProfile();
                  },
                ),
      
                   TextButton(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.deepOrange
                          ),
                        ),
                        onPressed: (){
                          logout(); 
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInScreen()));
                        }, 
                      )
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}
