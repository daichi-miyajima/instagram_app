import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add/add_page.dart';
import 'feed_model.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedModel>(context, listen: false).fetchFirebaseData(); // fetchFirebaseData() を呼び出す
    return Scaffold(
      body: Consumer<FeedModel>(
        builder: (context, feedModel, child) {
          if (feedModel.feeds.isEmpty) {
            print('空だよ');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: feedModel.feeds
                .map(
                  (feed) => ListTile(
                title: Row(
                  children: [
                    Text(
                      feed.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Wrap(
                      children: [
                        SizedBox(width: 16),
                        Chip(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 0.1),
                            child: Text(
                              feed.genre,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white, // タグの背景色
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(feed.description),
                trailing: feed.imageURL != null
                    ? SizedBox(
                  width: 100,
                  child: Image.network(
                    feed.imageURL!,
                    fit: BoxFit.cover, // 画像を目一杯に広げる
                  ),
                )
                    : null,
                onLongPress: () {
                  feedModel.deleteFeed(feed.id);
                },
                  ),
                ).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          ).then((_) => Provider.of<FeedModel>(context, listen: false)
              .fetchFirebaseData());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}