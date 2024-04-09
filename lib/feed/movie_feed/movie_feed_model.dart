import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../feeds.dart';

class MovieFeedModel extends ChangeNotifier {
  List<Feeds> feeds = [];

  void fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;
    final event = await db.collection("feeds").where("genre", isEqualTo: "movie").get();
    final docs = event.docs;
    final feeds = docs.map((doc) => Feeds.fromFirestore(doc)).toList();
    this.feeds = feeds;
    notifyListeners();
  }
}
