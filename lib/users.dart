import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String first;
  final String last;
  final int born;
  final String? imageURL; // imageURL を nullable に変更

  Users({
    required this.id,
    required this.first,
    required this.last,
    required this.born,
    this.imageURL,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Users(
      id: doc.id,
      first: data['first'],
      last: data['last'],
      born: data['born'],
      imageURL: data['imageURL'],
    );
  }
}