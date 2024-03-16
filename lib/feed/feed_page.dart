import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add/add_page.dart';
import '../component/header.dart';
import 'feed_model.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedModel>(context, listen: false).fetchFirebaseData(); // fetchFirebaseData() を呼び出す
    return Scaffold(
      appBar: Header(),
      body: Consumer<FeedModel>(
        builder: (context, feedModel, child) {
          if (feedModel.feeds.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: feedModel.feeds
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
                              // addModel.rankに応じて条件分岐
                              // if (feed.rank == 1) ...[
                              //   Icon(Icons.star, color: Colors.amber), // 1位の場合は星アイコンを金色に
                              //   Text('1', style: TextStyle(color: Colors.white)), // 1位の場合は数字を白色に
                              // ] else if (feed.rank == 2) ...[
                              //   Icon(Icons.star, color: Colors.grey), // 2位の場合は星アイコンを銀色に
                              //   Text('2', style: TextStyle(color: Colors.black)), // 2位の場合は数字を黒色に
                              // ] else if (feed.rank == 3) ...[
                              //   Icon(Icons.star, color: Colors.brown), // 3位の場合は星アイコンを銅色に
                              //   Text('3', style: TextStyle(color: Colors.black)), // 3位の場合は数字を黒色に
                              // ] else if (feed.rank == 4) ...[
                              //   Icon(Icons.star, color: Colors.brown), // 4位の場合は星アイコンを銅色に
                              //   Text('4', style: TextStyle(color: Colors.black)), // 4位の場合は数字を黒色に
                              // ] else if (feed.rank == 5) ...[
                              //   Icon(Icons.star, color: Colors.brown), // 5位の場合は星アイコンを銅色に
                              //   Text('5', style: TextStyle(color: Colors.black)), // 5位の場合は数字を黒色に
                              // ],
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle, // 1位から3位は星、4位と5位は丸
                                    size: 40, // アイコンのサイズを大きくする
                                    color: feed.rank == 1 ? Colors.amber : (feed.rank == 2 ? Colors.grey : (feed.rank == 3 ? Colors.brown : Colors.blueGrey)), // アイコンの色を設定
                                  ), // アイコンの色を設定
                                  Text(
                                    feed.rank.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
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