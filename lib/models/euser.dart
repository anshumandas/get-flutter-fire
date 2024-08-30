class EUser {
  String id;
  String name;
  String email;
  String phone;
  String? profileImageUrl;
  bool isDriver;
  bool hasActiveRide;
  String activeRideUid;
  List<String> rideUids;

  EUser({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.profileImageUrl,
    this.isDriver = false,
    this.hasActiveRide = false,
    this.activeRideUid = '',
    this.rideUids = const [],
  });

  factory EUser.fromMap(Map<String, dynamic> map) {
    return EUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImageUrl: map['profileImageUrl'],
      isDriver: map['isDriver'] ?? false,
      hasActiveRide: map['hasActiveRide'] ?? false,
      activeRideUid: map['activeRideUid'] ?? '',
      rideUids: List<String>.from(map['rideUids'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'isDriver': isDriver,
      'hasActiveRide': hasActiveRide,
      'activeRideUid': activeRideUid,
      'rideUids': rideUids,
    };
  }
}