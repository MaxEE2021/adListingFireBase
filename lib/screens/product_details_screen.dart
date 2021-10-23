
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:flutter/material.dart';

class ProducDetailsScreen extends StatelessWidget {
  // const ProducDetailsScreen({Key? key}) : super(key: key);
  final Map? allAds;
  const ProducDetailsScreen ({
    this.allAds,
  });

  @override
  Widget build(BuildContext context) {
    var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";
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

              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(img)
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0 , bottom: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outlined),
                        Text(
                          "all"
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          Text(
                            "4 days ago"
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
              )
              
            ],
          ),
        ),
      ),
    );
  }
}