
import 'package:classified_app/screens/create_add_screen.dart';
import 'package:classified_app/screens/edit_account_screen.dart';
import 'package:classified_app/screens/my_adds_screen.dart';
import 'package:classified_app/screens/settings_screen.dart';
import 'package:classified_app/widgets/card_item_widget.dart';
import 'package:classified_app/widgets/my_add_card_widget.dart';
import 'package:flutter/material.dart';

import 'edit_add_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_outlined),
        backgroundColor: Colors.deepOrange,
        // onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //   MyAddsScreen()));
        // }
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
              backgroundImage: NetworkImage(img,),
            ),
            style: TextButton.styleFrom(
              shape: CircleBorder()
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.count(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: size.height * 0.0014,
            children: <Widget> [
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              CardItemWidget(
                img: img,
                productTitle: "Product Title",
                price: "90000",
              ),
              Container(color: Colors.blue,),
              Container(color: Colors.blue,),

            ],
          ),
        ),
      )
    );
  }
} 