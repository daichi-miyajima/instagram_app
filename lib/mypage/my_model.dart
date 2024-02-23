import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  bool isLoading = false;
  // 色々追加したい
  String? first;
  String? last;
  String? imageURL;
  String? email;
  String? description;

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
    this.first = data?['first'];
    this.last = data?['last'];
    this.imageURL = data?['imageURL'];
    this.description = data?['description'];

    notifyListeners();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}