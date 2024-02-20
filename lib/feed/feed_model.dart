import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../users.dart';

class FeedModel extends ChangeNotifier {
  List<Users> users = [];

  void fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;
    final event = await db.collection("users").get();
    final docs = event.docs;
    final users = docs.map((doc) => Users.fromFirestore(doc)).toList();
    this.users = users;
    notifyListeners();
  }

  void updateUserBorn(String userId, int year) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'born': year});
    fetchFirebaseData();
  }

  void deleteUser(String userId) async {
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(userId).delete();
    fetchFirebaseData();
  }
}
