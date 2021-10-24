import 'package:classified_app/screens/edit_add_screen.dart';
import 'package:flutter/material.dart';

class MyAddCardWidget extends StatelessWidget {
  
  // const MyAddCardWidget({Key? key}) : super(key: key);
  
  
  final Map? adsData;
  final String title;
  final String price;

  const MyAddCardWidget ({
    this.adsData,
    this.title="",
    this.price="",
  });

  @override
  
  Widget build(BuildContext context) {
    var imgProduct = "http://luztra.mx/content/images/thumbs/default-image_450.png";
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(adsData!["adData"]["imgAd"] == null ?  imgProduct : adsData!["adData"]["imgAd"][0])
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    // "Samsung for sale",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:3.0),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        Text(
                          "10 days ago",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    price,
                    // "\$2000",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: (){
        print("you pressed my ad card widget");
        print(adsData!["adData"]["title"]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> EditAddScreen(
          adsData: adsData,
        )));
      },
    );
  }
}