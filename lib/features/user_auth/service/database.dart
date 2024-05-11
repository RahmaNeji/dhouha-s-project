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
      await Future.forEach([
        'Tunis',
        'Tozeur',
        'Sousse',
        'Nabeul',
        'Mahdia',
        'Bizerte',
        'Manouba',
        'SidiBouzid'
      ], (collection) async {
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
      print('Error updating favorite status: $e');
    }
  }

  Future<void> deletePlaceItem(String documentId) async {
    try {
      await Future.forEach(
        [
          'Tunis',
          'Tozeur',
          'Sousse',
          'Nabeul',
          'Mahdia',
          'Bizerte',
          'Manouba',
          'SidiBouzid'
        ],
        (collection) async {
          final documentReference =
              FirebaseFirestore.instance.collection(collection).doc(documentId);

          final docSnapshot = await documentReference.get();

          if (docSnapshot.exists) {
            await documentReference.delete();
            print(
                'Document $documentId deleted successfully from collection $collection');
          } else {
            print(
                'Document $documentId does not exist in collection $collection');
          }
        },
      );
    } catch (e) {
      print('Error deleting document: $e');
      // Handle error as needed
    }
  }
}
