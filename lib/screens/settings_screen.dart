


import 'package:classified_app/screens/edit_account_screen.dart';
import 'package:classified_app/screens/my_adds_screen.dart';
import 'package:flutter/material.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
  
}


class _SettingsScreenState extends State<SettingsScreen> {
  var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";

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
                      backgroundImage: NetworkImage(img),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "username",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Text(
                          "99999999",
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
                EditAccountScreen()));
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
                MyAddsScreen()));
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
                // _launchOtherApp("https://appmaking.co/flutter-courses/");
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
                // _launchOtherApp("https://appmaking.co/flutter-courses/");
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

}