import 'dart:io';
import 'dart:async';

import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAddScreen extends StatefulWidget {
  CreateAddScreen({Key? key}) : super(key: key);

  @override
  _CreateAddScreenState createState() => _CreateAddScreenState();
}

class _CreateAddScreenState extends State<CreateAddScreen> {
  var isCaptured = false;
  var path;
  List path2=[];

  Future capture()async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery).then((file){
      print(file!.path);
      setState(() {
        isCaptured = true;
        path = file.path;
        // path = File(file.path);
      });
    });
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
                    caputureMultipleImg();

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
                      itemCount: path2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: GalerryItemWidget(
                            fileimg: path2[index],
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
                customHintText: "Title",
                textType: TextInputType.text,
              ),
              CustomTextFieldWidget(
                customHintText: "Price",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                customHintText: "Contact Number",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                customHintText: "Description",
                textType: TextInputType.text,
                customMaxLines: 3,
              ),

              CustomButtonWidget(
                buttonText: "Submit Ad",
              )
              
            ],
          ),
        ),
      ),
    );
  }
}