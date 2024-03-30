import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterModel extends ChangeNotifier {
  // input項目を受け取る
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // フィールド
  String? name;
  File? imageFile;
  String? email;
  String? password;

  // ローディング
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

  // onChanegedでset関数を走らせる
  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    // Firebase Storageにアップロード
    final doc = FirebaseFirestore.instance.collection('users').doc();

    String? imageURL;
    if (imageFile != null) {
      // Storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('users/${doc.id}')
          .putFile(imageFile!);
      imageURL = await task.ref.getDownloadURL();
    }

    // inputされた値をregisterモデルのフィールドにセット
    this.name = nameController.text;
    this.email = emailController.text;
    this.password = passwordController.text;

    if (email != null && password != null) {
      // firebase authでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;

      if (user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        // 管理画面にpassword見れちゃいけない
        await doc.set({
          'uid': uid,
          'name': name,
          'imageURL': imageURL,
          'email': email,
        });
      }
    }
  }
}