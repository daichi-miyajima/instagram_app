import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddModel extends ChangeNotifier {
  String first = '';
  String last = '';

  // データの追加
  Future<void> addToFirebase() async {
    final db = FirebaseFirestore.instance;

    final user = <String, dynamic>{
      "first": first,
      "last": last,
      "born": 1991,
    };

    await db.collection("users").add(user);
  }
}
