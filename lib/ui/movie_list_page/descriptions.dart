import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posturl, vote, launch_on;

  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posturl,
      required this.vote,
      required this.launch_on});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      body: ListView(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    bannerurl,
                    fit: BoxFit.cover,
                  ),
                )),
                Positioned(
                    bottom: 10,
                    child: Text(
                      ' ⭐ Average Rating -' + vote,
                      style: TextStyle(
                          color: allTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              name != null ? name : 'Not Loaded',
              style:
                  TextStyle(color: allTextColor, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Relaseing On -' + launch_on,
              style:
                  TextStyle(color: allTextColor, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 200,
                width: 100,
                child: Image.network(posturl),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      description,
                      style: TextStyle(
                          color: allTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
