import 'package:VIDFLIX/ui/movie_list_page/toprated_list.dart';
import 'package:VIDFLIX/ui/movie_list_page/trending_list.dart';
import 'package:VIDFLIX/ui/movie_list_page/tv.dart';
import 'package:VIDFLIX/ui/setting_page_screen/setting_page.dart';
import 'package:VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key,});


  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List treandingmovielist = [];
  List topratedmovies = [];
  List tvlist = [];

  final String apiKey = '968fba15ed13780413e8e42517a9bd96';

  final readaccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjhmYmExNWVkMTM3ODA0MTNlOGU0MjUxN2E5YmQ5NiIsInN1YiI6IjY0NTlmODVkZmUwNzdhNWNhZmJjZmFiNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wbcThiooWkYiZ18P-wIxt-FmTyTdQFwPaZQFIq7CP4k';

  @override
  void initState() {
    loadMovieList();
    super.initState();
  }

  loadMovieList() async {
    TMDB tmdbWithCustomsLogs = TMDB(ApiKeys(apiKey, readaccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map trendingresults = await tmdbWithCustomsLogs.v3.trending.getTrending();
    Map topratedresults = await tmdbWithCustomsLogs.v3.movies.getTopRated();
    Map tvresults = await tmdbWithCustomsLogs.v3.tv.getPopular();

    setState(() {
      treandingmovielist = trendingresults['results'];
      topratedmovies = topratedresults['results'];
      tvlist = tvresults['results'];
    });
    print(treandingmovielist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: PreferredSize(
        child: MovieListAppbar(),
        preferredSize: Size.fromHeight(70.0),
      ),
      body: ListView(
        children: [
          TvScreen(tv: tvlist),
          TopRatedScreen(toprated: topratedmovies),
          TrendingScreen(trending: treandingmovielist),
        ],
      ),
    );
  }
}
