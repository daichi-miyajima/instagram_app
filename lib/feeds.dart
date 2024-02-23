import 'package:cloud_firestore/cloud_firestore.dart';

class Feeds {
  final String id;
  final String title;
  final String description;
  final String? imageURL;
  final String genre;

  Feeds({
    required this.id,
    required this.title,
    required this.description,
    this.imageURL,
    required this.genre,
  });

  factory Feeds.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Feeds(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      imageURL: data['imageURL'],
      genre: data['genre'],
    );
  }
}