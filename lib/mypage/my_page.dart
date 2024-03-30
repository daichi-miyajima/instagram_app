import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/component/header.dart';
import 'package:instagram/edit_profile/edit_profile_page.dart';
import 'package:instagram/login/login_page.dart';
import 'package:instagram/mypage/my_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);
  // image一覧
  final images = [
    'https://english-club.jp/wp-content/uploads/2019/07/english-brain-1024x717.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvoSuexQoraIJ3Xc8Qde7Y_A-7v7vfwWxveA&usqp=CAU',
    'https://www.pakutaso.com/shared/img/thumb/kaigoIMGL8113.jpg',
    'https://news.value-press.com/wp-content/uploads/interview_top_image_pakutaso.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyModel()..fetchUser(),
      child: Consumer<MyModel>(
        builder: (context, mymodel, child) {
          return Scaffold(
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
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    crossAxisCount: 3,
                    children: images.map((imageUrl) {
                      return InstagramPostItem(imageUrl: imageUrl);
                    }).toList(),
                  ),
                  // ListViewにしてtitleだけ表示する形にする
                  // ListView(
                  //     children: [
                  //       _menuItem("メニュー1", Icon(Icons.settings)),
                  //       _menuItem("メニュー2", Icon(Icons.map)),
                  //       _menuItem("メニュー3", Icon(Icons.room)),
                  //       _menuItem("メニュー4", Icon(Icons.local_shipping)),
                  //       _menuItem("メニュー5", Icon(Icons.airplanemode_active)),
                  //     ]
                  // ),
                ],
              ),
            ),
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