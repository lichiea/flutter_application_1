import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// класс для хранения избранного
// class MockFavoritesService {
//   final List<Map<String, dynamic>> _favorites = [];

//   Future<List<Map<String, dynamic>>> getFavorites() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return List.from(_favorites);
//   }

//   Future<void> addFavorite({
//     required String contentId,
//     required String title,
//     required String description,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 500));
    
//     // Проверяем, не добавлен ли уже этот элемент
//     bool alreadyExists = _favorites.any((item) => item['contentId'] == contentId);
//     if (alreadyExists) {
//       throw Exception('Элемент уже в избранном');
//     }
    
//     _favorites.add({
//       'id': DateTime.now().millisecondsSinceEpoch.toString(),
//       'contentId': contentId,
//       'title': title,
//       'description': description,
//       'timestamp': DateTime.now(),
//     });
//     print('Добавлено в избранное: $title');
//   }

//   Future<void> removeFavorite(String contentId) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     _favorites.removeWhere((item) => item['contentId'] == contentId);
//     print('Удалено из избранного: $contentId');
//   }

//   Future<bool> isFavorite(String contentId) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     return _favorites.any((item) => item['contentId'] == contentId);
//   }
// }

class FirestoreFavoritesService {
  CollectionReference get _userFavorites {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites');
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final querySnapshot = await _userFavorites
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> addFavorite({
    required String contentId,
    required String title,
    required String description,
  }) async {
    try {
      final existingQuery = await _userFavorites
          .where('contentId', isEqualTo: contentId)
          .get();
          
      if (existingQuery.docs.isNotEmpty) {
        throw Exception('Элемент уже в избранном');
      }
      
      await _userFavorites.add({
        'contentId': contentId,
        'title': title,
        'description': description,
        'timestamp': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> removeFavorite(String contentId) async {
    try {
      final querySnapshot = await _userFavorites
          .where('contentId', isEqualTo: contentId)
          .get();

      for (var doc in querySnapshot.docs) {
        await _userFavorites.doc(doc.id).delete();
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Future<bool> isFavorite(String contentId) async {
    try {
      final querySnapshot = await _userFavorites
          .where('contentId', isEqualTo: contentId)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }
}