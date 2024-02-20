import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/users.dart';

class MainModel extends ChangeNotifier {

  int _currentIndex = 0;
  List<Users> _users = [];

  int get currentIndex => _currentIndex;
  List<Users> get users => _users;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;
    final event = await db.collection("users").get();
    final docs = event.docs;
    final users = docs.map((doc) => Users.fromFirestore(doc)).toList();
    _users = users;
    notifyListeners();
  }

// 他に必要なメソッドや変数があればここに追加してください
}