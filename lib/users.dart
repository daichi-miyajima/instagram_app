import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String name;
  final int born;
  final String? imageURL; // imageURL を nullable に変更

  Users({
    required this.id,
    required this.name,
    required this.born,
    this.imageURL,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Users(
      id: doc.id,
      name: data['name'],
      born: data['born'],
      imageURL: data['imageURL'],
    );
  }
}