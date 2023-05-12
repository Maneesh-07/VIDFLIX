import 'package:VIDFLIX/ui/movie_list_page/descriptions.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:flutter/material.dart';

class TvScreen extends StatelessWidget {
  final List tv;

  const TvScreen({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular TV Shows",
            style: TextStyle(
                fontSize: 26, color: allTextColor, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Description(
                          name: tv[index]['original_name'],
                          description: tv[index]['overview'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500' +
                              tv[index]['backdrop_path'],
                          posturl: 'https://image.tmdb.org/t/p/w500' +
                              tv[index]['poster_path'],
                          vote: tv[index]['vote_average'].toString(),
                          launch_on: tv[index]['release_date'] != null
                              ? tv[index]['release_date']
                              : '   Loading....'),
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: 250,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 250,
                          height: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          tv[index]['poster_path']),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            tv[index]['original_name'] != null
                                ? tv[index]['original_name']
                                : 'Loading...',
                            style: TextStyle(
                                color: allTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
