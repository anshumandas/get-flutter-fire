import 'package:cloud_firestore/cloud_firestore.dart';

// Model
class RoleUpgradeRequest {
  final String id;
  final String userId;
  final String currentRole;
  final String requestedRole;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime createdAt;

  RoleUpgradeRequest({
    required this.id,
    required this.userId,
    required this.currentRole,
    required this.requestedRole,
    required this.status,
    required this.createdAt,
  });

  factory RoleUpgradeRequest.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return RoleUpgradeRequest(
      id: doc.id,
      userId: data['userId'],
      currentRole: data['currentRole'],
      requestedRole: data['requestedRole'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'currentRole': currentRole,
      'requestedRole': requestedRole,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
