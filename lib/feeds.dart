import 'package:cloud_firestore/cloud_firestore.dart';

class Feeds {
  final String id;
  final String title;
  final String description;
  final String? imageURL;
  final String genre;
  final int rank;
  final String userId;
  final String userName;
  final String userImageURL;

  Feeds({
    required this.id,
    required this.title,
    required this.description,
    this.imageURL,
    required this.genre,
    required this.rank,
    required this.userId,
    required this.userName,
    required this.userImageURL,
  });

  factory Feeds.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Feeds(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      imageURL: data['imageURL'],
      genre: data['genre'],
      rank: data['rank'],
      userId: data['userId'],
      userName: data['userName'],
      userImageURL: data['userImageURL'],
    );
  }
}