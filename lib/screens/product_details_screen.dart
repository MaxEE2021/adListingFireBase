
import 'package:classified_app/screens/gallery_viwer_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProducDetailsScreen extends StatelessWidget {
  // const ProducDetailsScreen({Key? key}) : super(key: key);
  final Map? allAds;
  const ProducDetailsScreen ({
    this.allAds,
  });
  
   Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    var img = "http://luztra.mx/content/images/thumbs/default-image_450.png";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allAds!["title"],
                // "Used Mackbook Pro for sale",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Text(
                  "\$ ${allAds!["price"]}",
                  // "\$ 40000",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                  ),
                ),
              ),

              InkWell(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(allAds!["imgAd"] == null ? img :allAds!["imgAd"][0])
                    )
                  ),
                ),
                onTap: (){
                  // print(images);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPage(
                    imageList: allAds!["imgAd"],
                  ))); 
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0 , bottom: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outlined),
                        Text(
                          allAds!["author"]
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          Text(
                            allAds!["creationDate"].toString()
                          )
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0),
                child: Text(
                  allAds!["description"],
                  // "sdkjfhsjf ksdhfkjs ksjdhf ksjdfhksjdfhs lkjsfdhs kdfjh ksjdfhksjdfh lksjh ksajdhkajsd flkjsafdhkjshdf lksjf",
                  
                ),
              ),

              CustomButtonWidget(
                buttonText: "Contact Seller",
                buttonFunction: (){
                  _makePhoneCall("tel: ${allAds!["number"]}");
                  // _makePhoneCall("tel:${allAds!["number"]}");
                },
              )
              
            ],
          ),
        ),
      ),
    );
  }
}