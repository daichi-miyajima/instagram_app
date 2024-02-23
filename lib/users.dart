import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String name;
  final String? imageURL; // imageURL を nullable に変更

  Users({
    required this.id,
    required this.name,
    this.imageURL,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Users(
      id: doc.id,
      name: data['name'],
      imageURL: data['imageURL'],
    );
  }
}