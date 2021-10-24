
import 'dart:ffi';
import 'dart:ui';

import 'package:classified_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CardItemWidget extends StatefulWidget {
  // CardItemWidget({Key? key}) : super(key: key);
  final String productTitle;
  final String price;
  final String img;
  final VoidCallback? onTap;
  final Map? allAds;

  const CardItemWidget ({
    this.productTitle="Product Title",
    this.price="99999",
    this.img="",
    this.onTap,
    this.allAds,
  });

  @override
  _CardItemWidgetState createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  // var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage( widget.allAds!["imgAd"] == null ?  widget.img : widget.allAds!["imgAd"][0]) 
                ),
              )
            ),
      
            Column(
              children: [
                Expanded(
                  child: Container(
                  ),
                ),
                Container(
                  width: double.infinity,
                  color : Color(0x8f151515),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productTitle,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(
                          "\$ ${widget.price}",
                          style: TextStyle(
                            color: Colors.orange
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        onTap: widget.onTap == null ? 
          (){
            print("you clicked the product");
            print(widget.allAds!["imgAd"]);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProducDetailsScreen(
              allAds: widget.allAds,
            )));
          }
          :
          widget.onTap,
      ),
    );
  }
}