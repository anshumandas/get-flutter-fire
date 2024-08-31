import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference bucketlist =
      FirebaseFirestore.instance.collection('bucketlist');

  Future<void> addBucketListItem(String item, String userId) {
    return bucketlist.add({
      'item': item,
      'userId': userId,
      'completed': false,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getBucketListStream(String userId) {
    final bucketListStream = bucketlist
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return bucketListStream;
  }

  Future<void> updateBucketListItem(String docID, String newItem) {
    return bucketlist.doc(docID).update({
      'item': newItem,
      'timestamp': Timestamp.now()
    });
  }

  Future<void> deleteBucketListItem(String docID) {
    return bucketlist.doc(docID).delete();
  }
}
