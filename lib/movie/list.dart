import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = Dio();

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.mt});

  final String mt;

  @override
  MovieListState createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  int pagesize = 10;
  var mlist = [];
  var total = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: mlist.length,
      itemBuilder: (BuildContext ctx, int i) {
        var mitem = mlist[i];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext ctx) {
                  return MovieDetail(
                    id: mitem['id'],
                    title: mitem['title'],
                  );
                },
              ),
            );
          },
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12),
              ),
            ),
            child: Row(
              children: <Widget>[
                Image.network(
                  'https://picsum.photos/130/180',
                  width: 130,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('电影名称：${mitem['title']}'),
                      Text('上映年份：${mitem['category']}'),
                      Text('电影类型：${mitem['user']}'),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getMovieList() async {
    // int offset = (page - 1) * pagesize;
    var res = await dio.post('http://192.168.113.40:3000/api/article/list');
    var result = res.data['data'];

    setState(() {
      mlist = result['rows'];
      total = result['count'];
    });
  }
}
