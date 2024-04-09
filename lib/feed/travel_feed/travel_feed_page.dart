import 'package:flutter/material.dart';
import 'package:instagram/feed/travel_feed/travel_feed_model.dart';
import 'package:provider/provider.dart';

import '../../component/header.dart';

class TravelFeedPage extends StatelessWidget {
  const TravelFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TravelFeedModel>(context, listen: false).fetchFirebaseData(); // fetchFirebaseData() を呼び出す
    return Scaffold(
      appBar: Header(),
      body: Consumer<TravelFeedModel>(
        builder: (context, travelFeedModel, child) {
          if (travelFeedModel.feeds.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: travelFeedModel.feeds
                  .map(
                    (feed) => ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(feed.userImageURL), // ユーザー画像
                          ),
                          SizedBox(width: 8),
                          Text(
                            feed.userName, // ユーザー名
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              feed.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Wrap(
                            children: [
                              Chip(
                                label: Text(
                                  feed.genre,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor: Colors.white, // タグの背景色
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    feed.rank == 1 ? Icons.star : (feed.rank == 2 ? Icons.star : (feed.rank == 3 ? Icons.star : Icons.circle)), // アイコンの色を設定,
                                    size: 48, // アイコンのサイズを大きくする
                                    color: feed.rank == 1 ? Colors.amber : (feed.rank == 2 ? Colors.grey : (feed.rank == 3 ? Colors.brown : Colors.blueGrey)), // アイコンの色を設定
                                  ), // アイコンの色を設定
                                  Text(
                                    feed.rank.toString(),
                                    style: TextStyle(
                                      color: feed.rank == 1 ? Colors.black : (feed.rank == 2 ? Colors.black : (feed.rank == 3 ? Colors.black : Colors.white)), // アイコンの色を設定
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ), // 数字の色は黒色に
                                ],
                              ),
                            ],
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
                ),
              ).toList(),
            );
          }
        },
      ),
    );
  }
}