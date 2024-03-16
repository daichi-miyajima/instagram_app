import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../feeds.dart';

class AddModel extends ChangeNotifier {
  String title = '';
  String description = '';
  File? imageFile;
  String genre = 'movie';
  int rank = 1;

  List<Feeds> feeds = [];

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // カメラロール開いて写真選ぶ
  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  // データの追加
  Future<void> addToFirebase() async {

    final doc = FirebaseFirestore.instance.collection('feeds').doc();

    String? imageURL;
    if (imageFile != null) {
      // Storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('feeds/${doc.id}')
          .putFile(imageFile!);
      imageURL = await task.ref.getDownloadURL();
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();

    // firestoreに追加
    await doc.set({
      'title': title,
      'description': description,
      'imageURL': imageURL,
      'genre': genre,
      'rank': rank,
      'userId': data?['uid'],
      'userName': data?['name'],
      'userImageURL': data?['imageURL'],
    });
  }

  void fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;
    final event = await db.collection("feeds").get();
    final docs = event.docs;
    final feeds = docs.map((doc) => Feeds.fromFirestore(doc)).toList();
    this.feeds = feeds;
    notifyListeners();
  }

  void setGenre(String value) {
    this.genre = value;
  }

  void setRank(int value) {
    this.rank = value;
  }
}
