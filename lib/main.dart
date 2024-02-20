import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/search_page.dart';
import 'package:instagram/users.dart';

import 'main_model.dart';
import 'pages/feed_page.dart';
import 'pages/my_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainModel(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class MyHomePage extends StatelessWidget {
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  // int _currentIndex = 0;
  // final _pageWidgets = [
  //   const FeedPage(), // タイムライン
  //   SearchPage(),
  //   MyPage(), // マイページ
  // ];

  // List<Users> users = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchFirebaseData();
  // }

  // void _fetchFirebaseData() async {
  //   final db = FirebaseFirestore.instance;
  //   final event = await db.collection("users").get();
  //   final docs = event.docs;
  //   final users = docs.map((doc) => Users.fromFirestore(doc)).toList();
  //   setState(() {
  //     this.users = users;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final mainModel = Provider.of<MainModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ベストカルチャー'),
        actions: [
          IconButton(
            onPressed: () async {
              // Providerを先に行うので放置
              // 画面遷移
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginPage(),
              //     fullscreenDialog: true,
              //   ),
              // );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      // body: _pageWidgets.elementAt(_currentIndex),
      body: const _PageNavigator(),
      bottomNavigationBar: Consumer<MainModel>(
        builder: (context, mainModel, child) => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'タイムライン'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
          ],
          currentIndex: mainModel.currentIndex,
          onTap: (index) {
            mainModel.setCurrentIndex(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }
}

class _PageNavigator extends StatelessWidget {
  const _PageNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainModel = Provider.of<MainModel>(context, listen: false);

    return Consumer<MainModel>(
      builder: (context, mainModel, child) {
        final List<Widget> _pageWidgets = [
          const FeedPage(), // タイムライン
          const SearchPage(),
          MyPage(), // マイページ
        ];

        return _pageWidgets[mainModel.currentIndex];
      },
    );
  }
}