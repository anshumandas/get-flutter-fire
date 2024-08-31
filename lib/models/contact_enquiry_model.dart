import 'dart:convert';

import 'package:get_flutter_fire/enums/enum_parser.dart';
import 'package:get_flutter_fire/enums/enums.dart';

class ContactEnquiryModel {
  final String id;
  final String message;
  final String userID;
  final EnquiryStatus status;
  final DateTime timestamp;
  final String reference;
  final QueryType queryType;
  ContactEnquiryModel({
    required this.id,
    required this.message,
    required this.userID,
    required this.status,
    required this.timestamp,
    required this.reference,
    required this.queryType,
  });

  ContactEnquiryModel copyWith({
    String? id,
    String? message,
    String? userID,
    EnquiryStatus? status,
    DateTime? timestamp,
    String? reference,
    QueryType? queryType,
  }) {
    return ContactEnquiryModel(
      id: id ?? this.id,
      message: message ?? this.message,
      userID: userID ?? this.userID,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      reference: reference ?? this.reference,
      queryType: queryType ?? this.queryType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'userID': userID,
      'status': status.name,
      'timestamp': timestamp,
      'reference': reference,
      'queryType': queryType.name,
    };
  }

  factory ContactEnquiryModel.fromMap(Map<String, dynamic> map) {
    return ContactEnquiryModel(
      id: map['id'] as String,
      message: map['message'] as String,
      userID: map['userID'] as String,
      status: parseQueryStatus(map['status'] as String),
      timestamp: map['timestamp'].toDate(),
      reference: map['reference'] as String,
      queryType: parseQueryType(map['queryType'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactEnquiryModel.fromJson(String source) =>
      ContactEnquiryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, message: $message, userID: $userID, status: $status, timestamp: $timestamp, reference: $reference, queryType: $queryType)';
  }
}
