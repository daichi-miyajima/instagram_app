import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';
import '../mypage/my_page.dart';

class Header extends StatelessWidget implements PreferredSizeWidget{
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('TalkBest'),
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // AppBarの高さを指定
}