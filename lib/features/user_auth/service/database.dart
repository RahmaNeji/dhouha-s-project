import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addCountryItem(Map<String, dynamic> UserInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(UserInfoMap);
  }

  Future<Stream<QuerySnapshot>> getPlaceItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  // Future<void> updateFavoriteStatus(
  //     String documentId, bool favoriteStatus) async {
  //   await FirebaseFirestore.instance.collection(name).doc(documentId).update({
  //     'Favorite': favoriteStatus,
  //   });
  // }
  Future<void> updateFavoriteStatus(
      String documentId, bool favoriteStatus) async {
    try {
      // Try to update the document in each collection
      await Future.forEach(
          ['Tunis', 'Tozeur', 'Sousse', 'Nabeul', 'Mahdia', 'Bizerte'],
          (collection) async {
        final docSnapshot = await FirebaseFirestore.instance
            .collection(collection)
            .doc(documentId)
            .get();
        if (docSnapshot.exists) {
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(documentId)
              .update({
            'Favorite': favoriteStatus,
          });
        }
      });
    } catch (e) {
      // Handle any errors or exceptions
      print('Error updating favorite status: $e');
    }
  }
}
