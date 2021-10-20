import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EditAddScreen extends StatefulWidget {
  EditAddScreen({Key? key}) : super(key: key);

  @override
  _EditAddScreenState createState() => _EditAddScreenState();
}

class _EditAddScreenState extends State<EditAddScreen> {
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

                  },

                ),
              ),


              Container(
                height: 100,
                // color: Colors.blue,
                child: Row(
                  children: [
                    GalerryItemWidget(
                      img: img,
                      // height: size.height*0.15 ,
                      // width: size.height*0.12 ,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15.0),
                      child: GalerryItemWidget(
                        img: img,
                        // height: size.height*0.15 ,
                        // width: size.height*0.12 ,
                      ),
                    ),
                    GalerryItemWidget(
                      img: img,
                      // height: size.height*0.15 ,
                      // width: size.height*0.12 ,
                    ),
                  ],
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