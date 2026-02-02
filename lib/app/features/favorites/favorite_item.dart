import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteItem {
  final String id;
  final String userId;
  final String contentId;
  final String title;
  final String description;
  final Timestamp timestamp;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.contentId,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'contentId': contentId,
      'title': title,
      'description': description,
      'timestamp': timestamp,
    };
  }

  factory FavoriteItem.fromJson(String id, Map<String, dynamic> json) {
    return FavoriteItem(
      id: id,
      userId: json['userId'] as String,
      contentId: json['contentId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }
}