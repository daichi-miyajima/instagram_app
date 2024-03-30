import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../feeds.dart';

class MyModel extends ChangeNotifier {
  bool isLoading = false;
  // 色々追加したい
  String? name;
  String? imageURL;
  String? email;
  // Map<int, String>? feedRankAndTitle;
  List<Feeds>? myFeeds = [];

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    this.email = user?.email;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    this.name = data?['name'];
    this.imageURL = data?['imageURL'];
    // this.feedRankAndTitle = data?['feedRankAndTitle'];

    // このユーザのfeedsを取得する
    final db = FirebaseFirestore.instance;
    final event = await db.collection("feeds").where('userId', isEqualTo: uid).get();
    final docs = event.docs;
    final feeds = docs.map((doc) => Feeds.fromFirestore(doc)).toList();
    this.myFeeds = feeds;

    notifyListeners();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}