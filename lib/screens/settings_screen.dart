


import 'package:classified_app/screens/edit_account_screen.dart';
import 'package:classified_app/screens/my_adds_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsScreen extends StatefulWidget {
  // const SettingsScreen({Key? key}) : super(key: key);
  final String ProfilePicFirebase;

  const SettingsScreen ({
    this.ProfilePicFirebase="https://freesvg.org/img/abstract-user-flat-4.png",
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
  
}


class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _launchOtherApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  List adsDataList =[];
  String name = "UserName";
  String number = "+52";
  String imgProfFireBase = "";
  // List adsID=[];
  @override
  void initState() {
    super.initState();
    getUserData();
    getAdData();
  }
   getAdData(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).collection("ads").get().then((snapshot){
      snapshot.docs.forEach((doc) {
        // adDataList.add(doc.data());
        adsDataList.add({"adID":doc.id,"adData": doc.data()});
        // print(adsDataList[0]["adID"]);
        // adsID.add(doc.id);
        // print(doc.data());
      });
      setState(() {});
    });
  }

  
  getUserData(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((resp){
      name = resp["name"];
      number= resp["number"];
      imgProfFireBase=resp["img"];
    });
  }
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
      ),
      body: Padding(padding: EdgeInsetsDirectional.all(20),
      child: Container(
        // height: 230,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:34.0),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(widget.ProfilePicFirebase),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          // "username",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Text(
                          number,
                          // "99999999",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Edit",
                    style:TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                    ),
                  )    
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                EditAccountScreen(
                  imgProfFirebse: imgProfFireBase,
                )));
        },
            ),



            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.post_add_outlined,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "My Add",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                MyAddsScreen(
                  adsData: adsDataList,
                )));
        },
            ),
            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.person_outline,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "About us",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                _launchOtherApp("https://appmaking.co/flutter-courses/");
              },
            ),
            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.contacts_outlined,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "Contact us",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                _launchOtherApp("https://appmaking.co/flutter-courses/");
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

}