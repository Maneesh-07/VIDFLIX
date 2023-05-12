import 'package:VIDFLIX/ui/movie_list_page/descriptions.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

class TopRatedScreen extends StatelessWidget {
  final List toprated;

  const TopRatedScreen({super.key, required this.toprated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Rated Movies",
            style: TextStyle(
                fontSize: 26, color: allTextColor, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: toprated.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Description(
                          name: toprated[index]['title'],
                          description: toprated[index]['overview'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500' +
                              toprated[index]['backdrop_path'],
                          posturl: 'https://image.tmdb.org/t/p/w500' +
                              toprated[index]['poster_path'],
                          vote: toprated[index]['vote_average'].toString(),
                          launch_on: toprated[index]['release_date']),
                    ));
                  },
                  child: toprated[index]['title']!=null?
                  Container(
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
                                          toprated[index]['poster_path']))),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            toprated[index]['title'] != null
                                ? toprated[index]['title']
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
