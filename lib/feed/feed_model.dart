import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../feeds.dart';
import '../users.dart';

class FeedModel extends ChangeNotifier {
  List<Feeds> feeds = [];
  List<Users> users = [];

  void fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;
    final event = await db.collection("feeds").get();
    final docs = event.docs;
    final feeds = docs.map((doc) => Feeds.fromFirestore(doc)).toList();
    this.feeds = feeds;
    notifyListeners();
  }

  void deleteFeed(String feedId) async {
    final db = FirebaseFirestore.instance;
    await db.collection("feeds").doc(feedId).delete();
    fetchFirebaseData();
  }
}
