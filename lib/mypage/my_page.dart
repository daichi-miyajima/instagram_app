import 'package:flutter/material.dart';
import 'package:instagram/component/header.dart';
import 'package:instagram/edit_profile/edit_profile_page.dart';
import 'package:instagram/login/login_page.dart';
import 'package:instagram/mypage/my_model.dart';
import 'package:provider/provider.dart';

import '../add/add_page.dart';
import '../feed/feed_model.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyModel()..fetchUser(),
      child: Consumer<MyModel>(
        builder: (context, mymodel, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: Header(),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50, // サイズを調整する値を設定します
                            backgroundImage: NetworkImage(mymodel.imageURL ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='), // ユーザー画像
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
                              children: [
                                Text(
                                  mymodel.name ?? '名前なし',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '@dacchiman',
                                ),
                                Text(
                                  '#映画#ドラマ#旅行',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const SizedBox(width: 16),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              // 画面遷移
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(mymodel.name!),
                                ),
                              );
                              mymodel.fetchUser();
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              // ログアウト
                              await mymodel.logout();
                              // Navigator.of(context).pop();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: Text('ログアウト'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                              'My Talk Best5'
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.movie),
                          text: '映画',
                        ),
                        Tab(
                          icon: Icon(Icons.flight),
                          text: '旅行',
                        ),
                        Tab(
                          icon: Icon(Icons.airline_seat_recline_extra),
                          text: 'サウナ',
                        ),
                      ],
                    ),
                    // タブ1のコンテンツ
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5, // タブの高さに合わせて調整
                      child: TabBarView(
                        children: [
                          // タブ1のコンテンツ
                          ListView(
                            children: (mymodel.myFeeds!.where((feed) => feed.genre == 'movie').toList()
                              ..sort((a, b) => a.rank.compareTo(b.rank)))
                                .map<Widget>((feed) => ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    feed.rank.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    feed.title,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              subtitle: null,
                            ),
                            ).toList(),
                          ),
                          // タブ2のコンテンツ
                          ListView(
                            children: (mymodel.myFeeds!.where((feed) => feed.genre == 'travel').toList()
                              ..sort((a, b) => a.rank.compareTo(b.rank)))
                                .map<Widget>((feed) => ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    feed.rank.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    feed.title,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              subtitle: null,
                            ),
                            ).toList(),
                          ),
                          // タブ3のコンテンツ
                          ListView(
                            children: (mymodel.myFeeds!.where((feed) => feed.genre == 'sauna').toList()
                              ..sort((a, b) => a.rank.compareTo(b.rank)))
                                .map<Widget>((feed) => ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    feed.rank.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    feed.title,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              subtitle: null,
                            ),
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPage()
                    ),
                  );
                  mymodel.fetchUser();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            )
          );
        },
      ),
    );
  }
}

class InstagramPostItem extends StatelessWidget {
  const InstagramPostItem({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}