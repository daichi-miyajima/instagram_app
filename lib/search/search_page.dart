import 'package:flutter/material.dart';
import 'package:instagram/feed/movie_feed/movie_feed_page.dart';
import 'package:instagram/feed/sauna_feed/sauna_feed_page.dart';
import 'package:instagram/feed/travel_feed/travel_feed_page.dart';
import 'package:instagram/search/search_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchModel>(
      create: (_) => SearchModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('検索'),
        ),
        body: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MovieFeedPage()), // 遷移先の画面を指定
                      );
                    },
                    child: const Center(
                      child: ListTile(
                        title: Text(
                          '映画',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.movie),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TravelFeedPage()), // 遷移先の画面を指定
                      );
                    },
                    child: const Center(
                      child: ListTile(
                        title: Text(
                          '旅行',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.flight),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SaunaFeedPage()), // 遷移先の画面を指定
                      );
                    },
                    child: const Center(
                      child: ListTile(
                        title: Text(
                          'サウナ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.airline_seat_recline_extra),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      );
  }
}