import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:classified_app/screens/validation_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAddScreen extends StatefulWidget {
  CreateAddScreen({Key? key}) : super(key: key);

  @override
  _CreateAddScreenState createState() => _CreateAddScreenState();
}

class _CreateAddScreenState extends State<CreateAddScreen> {
  var isCaptured = false;
  List path2=[];
  var numereOfads =0;

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _numberCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserAds();
  }

  caputureMultipleImg() async {
      await ImagePicker().pickMultiImage().then((file) {
        for(int x=0;x<file!.length; x++){
          // print(file[x].path);
          path2.add(file[x].path);
        }
        // print(path2);
        // print(path2.length);
        setState(() {
          isCaptured=true;
        });
      });
    }
// this is the oldone create add, is a collection inside userDB
// at the end this function was better
    createNewAd(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    // var adID = "AD-${FirebaseAuth.instance.currentUser!.uid}";
    FirebaseFirestore.instance.collection("users").doc(uid).collection("ads").doc().
    set({
      "title"         : _titleCtrl.text,
      "price"         : _priceCtrl.text,
      "number"        : _numberCtrl.text,
      "description"   : _descCtrl.text,
      "imgAd"         : imagesUploaded,
    });
    print("New ad created");
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ValidationScreen()));
  }
//this is te good one because is out from users
// this function works but is more complicated to fetch data
  //    createNewAd2(){
  //   var uid = FirebaseAuth.instance.currentUser!.uid;
  //   if (numereOfads > 0){
  //     FirebaseFirestore.instance.collection("ads").doc(uid).update({
  //       "ad-${numereOfads+1}": {
  //         "title"         : _titleCtrl.text,
  //         "price"         : _priceCtrl.text,
  //         "number"        : _numberCtrl.text,
  //         "description"   : _descCtrl.text,
  //         // "imgAd" : ""
  //       },
  //     });
  //     print("New ad created");
  //   }
  //   else{
  //     FirebaseFirestore.instance.collection("ads").doc(uid).set({
  //       "ad-${numereOfads+1}": {
  //         "title"         : _titleCtrl.text,
  //         "price"         : _priceCtrl.text,
  //         "number"        : _numberCtrl.text,
  //         "description"   : _descCtrl.text,
  //         // "imgAd" : ""
  //       },
  //     });
  //     print("New ad created");
  //   }
  // }

  // getUserAds(){
  //   var uid = FirebaseAuth.instance.currentUser!.uid;
  //   if(numereOfads>0){
  //     var uid = FirebaseAuth.instance.currentUser!.uid;
  //     FirebaseFirestore.instance.collection("ads").doc(uid).get().then((snapshot){
  //       // print(snapshot.data()!.length);
  //       numereOfads = snapshot.data()!.length;
  //     });
  //   }
  //   else{
  //     FirebaseFirestore.instance.collection("users").doc(uid).collection("ads");
  //   }
  // }

  getUserAds(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    // if(numereOfads>0){
      FirebaseFirestore.instance.collection("users").doc(uid).collection("ads").get().then((snapshot){
        numereOfads = snapshot.docs.length;
        print(numereOfads);
        // snapshot.docs.forEach((doc) {
        //   print(doc.data().length);
        // });
        setState(() {});
      });
    // }
    // else{
    //   FirebaseFirestore.instance.collection("users").doc(uid).collection("ads").snapshots();
    //   setState(() {});
    // }
  }
  var imagesUploaded=[];
  uploadMultipleImg() async {
    var picker = ImagePicker();
    var pickedFiles = await picker.pickMultiImage();
    if (pickedFiles!.isNotEmpty) {
      for (var image in pickedFiles) {
        File img = File(image.path);
        var rng = Random();
        FirebaseStorage.instance
            .ref()
            .child("images")
            .child(rng.nextInt(10000).toString())
            .putFile(img)
            .then((res) {
          res.ref.getDownloadURL().then((url) {
            setState(() {
              imagesUploaded.add(url);
              isCaptured = true;
            });
          });
        }).catchError((e) {
          print(e.toString());
        });
      }
    } else {
      print('Select photos');
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Add"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10 ,bottom: 15),
                child: TextButton(
                  child: Container(
                    height: size.height*0.20,
                    // height: size.width*0.30,
                    width: size.width*0.38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: size.height*0.12,
                          
                        ),
                      
                        Text(
                          "Tap to upload",
                          style: TextStyle(
                            fontSize: size.height * 0.03
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                     primary: Colors.black
                  ),
                  onPressed: (){
                    print("upload a picture");
                    // capture();
                    // caputureMultipleImg();
                    uploadMultipleImg();

                  },

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  child: isCaptured ?

                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imagesUploaded.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: GalerryItemWidget(
                            img: imagesUploaded[index],
                          ),
                        );
                      },
                    ),
                  )

                  :
                  
                  Container(
                    height: 5,
                  )
                ),
              ),



              CustomTextFieldWidget(
                cstmController: _titleCtrl,
                customHintText: "Title",
                textType: TextInputType.text,
              ),
              CustomTextFieldWidget(
                cstmController: _priceCtrl,
                customHintText: "Price",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                cstmController: _numberCtrl,
                customHintText: "Contact Number",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                cstmController: _descCtrl,
                customHintText: "Description",
                textType: TextInputType.text,
                customMaxLines: 3,
              ),

              CustomButtonWidget(
                buttonText: "Submit Ad",
                buttonFunction: (){
                  // createNewAd();
                  createNewAd();
                },
              )
              
            ],
          ),
        ),
      ),
    );
  }
  
}