import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddModel extends ChangeNotifier {
  String first = '';
  String last = '';
  File? imageFile;

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
  Future<void> addImage() async {

    final doc = FirebaseFirestore.instance.collection('users').doc();

    String? imageURL;
    if (imageFile != null) {
      // Storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('users/${doc.id}')
          .putFile(imageFile!);
      imageURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'first': first,
      'last': last,
      "born": 1991,
      'imageURL': imageURL,
    });
  }
}
