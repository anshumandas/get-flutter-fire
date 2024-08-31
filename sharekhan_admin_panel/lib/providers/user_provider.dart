import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    final querySnapshot = await usersRef.get();
    _users =
        querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    notifyListeners();
  }
}
