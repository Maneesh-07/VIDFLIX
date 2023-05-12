import 'package:VIDFLIX/ui/movie_list_page/descriptions.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

class TrendingScreen extends StatelessWidget {
  final List trending;

  const TrendingScreen({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Movies",
            style: TextStyle(
                fontSize: 26, color: allTextColor, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Description(
                          name: trending[index]['title'],
                          description: trending[index]['overview'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500' +
                              trending[index]['backdrop_path'],
                          posturl: 'https://image.tmdb.org/t/p/w500' +
                              trending[index]['poster_path'],
                          vote: trending[index]['vote_average'].toString(),
                          launch_on: trending[index]['release_date']),
                    ));
                  },
                  child:
                  trending[index]['title']!=null? Container(
                    width: 140,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']))),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            trending[index]['title'] != null
                                ? trending[index]['title']
                                : 'Loading...',
                            style: TextStyle(color: allTextColor),
                          ),
                        )
                      ],
                    ),
                  ):Container(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
