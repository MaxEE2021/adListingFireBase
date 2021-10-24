
import 'dart:convert';

import 'package:classified_app/screens/create_add_screen.dart';
import 'package:classified_app/screens/edit_account_screen.dart';
import 'package:classified_app/screens/my_adds_screen.dart';
import 'package:classified_app/screens/settings_screen.dart';
import 'package:classified_app/widgets/card_item_widget.dart';
import 'package:classified_app/widgets/my_add_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_add_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var img = "https://freesvg.org/img/abstract-user-flat-4.png";
  var imgProduct = "http://luztra.mx/content/images/thumbs/default-image_450.png";
  var imgServer = "";


  var allAds=[];
  @override
  void initState() {
    super.initState();
    getAllAds();
    getUserData();
  }

  Future getAllAds()async{
    allAds=[];
    var _tempAllAds=[];
    await FirebaseFirestore.instance.collection("users").get().then((value){
      value.docs.forEach((doc) { 
        print(doc.id);
        FirebaseFirestore.instance.collection("users").doc(doc.id).collection("ads").get().then((snapshot){
          snapshot.docs.forEach((element) {
            // print(element.data());
            // _tempAllAds.add(element.data());
            allAds.add(element.data());
            // print(allAds.length);
            setState(() {});
          });
          
        });
      });
     
    });

  }

   getUserData(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((resp){
      print(resp.data());
      imgServer = resp.data()!["img"];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_outlined),
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CreateAddScreen()));
        }
      ),
      appBar: AppBar(
        title: Text("Adds Listing"),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            child: CircleAvatar(
              // radius: 30,
              backgroundImage: NetworkImage(imgServer == "" ? img:imgServer),
            ),
            style: TextButton.styleFrom(
              shape: CircleBorder()
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(
                ProfilePicFirebase: imgServer == "" ? img:imgServer,
              )));
            },
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicator(
          backgroundColor: Colors.deepOrange,
          color: Colors.white,
          displacement: 8,
          strokeWidth: 3,
          onRefresh: getAllAds,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child:  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: size.height * 0.0014,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: allAds.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardItemWidget(
                    img: imgProduct,
                    productTitle: allAds[index]["title"],
                    price: allAds[index]["price"],
                    allAds: allAds[index],
                  );
                },
              ),
            
          ),
        ),
      )
    );
  }
} 