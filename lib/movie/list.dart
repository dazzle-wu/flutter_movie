import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.mt});

  final String mt;

  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Text('电影列表${widget.mt}');
  }

  getMovieList() {
    dio.get('');
  }
}
