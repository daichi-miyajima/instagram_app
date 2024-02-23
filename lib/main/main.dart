import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/add/add_model.dart';
import '../login/login_page.dart';
import '../search/search_page.dart';

import '../feed/feed_model.dart';
import 'main_model.dart';
import '../feed/feed_page.dart';
import '../mypage/my_page.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainModel()),
        ChangeNotifierProvider(create: (_) => FeedModel()),
        ChangeNotifierProvider(create: (_) => AddModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ベストカルチャー'),
        actions: [
          IconButton(
            onPressed: () async {
              // 画面遷移
              if (FirebaseAuth.instance.currentUser != null) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPage(),
                    fullscreenDialog: true,
                  ),
                );
              } else {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
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
}

class _PageNavigator extends StatelessWidget {
  const _PageNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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