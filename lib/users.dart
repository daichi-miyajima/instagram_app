import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String first;
  final String last;
  final int born;

  Users({
    required this.id,
    required this.first,
    required this.last,
    required this.born,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Users(
      id: doc.id,
      first: data['first'],
      last: data['last'],
      born: data['born'],
    );
  }
}