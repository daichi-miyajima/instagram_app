import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../users.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _FeedPage();
}

class _FeedPage extends State<SearchPage> {
  List<Users> users = [];

  @override
  void initState() {
    super.initState();
    // _fetchFirebaseData(); // ページ読み込みでfetchする
  }

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
    return Scaffold(
      body: ListView(
        )
      );
  }
}