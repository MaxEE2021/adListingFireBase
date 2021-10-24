
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAddScreen extends StatefulWidget {
  // EditAddScreen({Key? key}) : super(key: key);
  final Map? adsData;
  const EditAddScreen({
    this.adsData,
  });

  @override
  _EditAddScreenState createState() => _EditAddScreenState();
}

class _EditAddScreenState extends State<EditAddScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _numberCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleCtrl.text = widget.adsData!["adData"]["title"];
    _priceCtrl.text = widget.adsData!["adData"]["price"];
    _numberCtrl.text = widget.adsData!["adData"]["number"];
    _descCtrl.text = widget.adsData!["adData"]["description"];
  }

      
   updateAd(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var adID = widget.adsData!["adID"];
    print(uid); 
    print(adID);
    FirebaseFirestore.instance.collection("users").doc(uid).collection("ads").doc(adID).
    update({
      "title"         : _titleCtrl.text,
      "price"         : _priceCtrl.text,
      "number"        : _numberCtrl.text,
      "description"   : _descCtrl.text,
      "imgAd"         : imagUploaded
    });
    print("Ad updated");
  }
  var imagUploaded = [];
  uploadMultipleImg() async {
    imagUploaded = widget.adsData!["adData"]["imgAd"];
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
              imagUploaded.add(url);
              // widget.adsData!["adData"]["imgAd"].add(url);
              // isCaptured = true;
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

  var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Add"),
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
                    height: size.height*0.18,
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
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  style: TextButton.styleFrom(
                     primary: Colors.black
                  ),
                  onPressed: (){
                    uploadMultipleImg();
                  },

                ),
              ),


              Container(
                height: 100,
                // color: Colors.blue,
                child:  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.adsData!["adData"]["imgAd"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: GalerryItemWidget(
                            img: widget.adsData!["adData"]["imgAd"][index],
                          ),
                        );
                      },
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
                  updateAd();
                },
              )
              
            ],
          ),
        ),
      ),
    );
  }
}