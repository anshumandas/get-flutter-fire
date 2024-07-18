class RoleRequest {
  String userId;
  String requestedRole;
  bool approved;

  RoleRequest({required this.userId, required this.requestedRole, this.approved = false});

  factory RoleRequest.fromMap(Map<String, dynamic> data) {
    return RoleRequest(
      userId: data['userId'],
      requestedRole: data['requestedRole'],
      approved: data['approved'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'requestedRole': requestedRole,
      'approved': approved,
    };
  }
}
