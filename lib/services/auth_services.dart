import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // sign in

  Future<User?> signInWithEmailAndPassword(String email, String password) async
  {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  } 
  // sign up

  Future<User?> registerWithEmailAndPassword(String email, String password) async
  {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  } 
  // sign out
  Future<void> signout() async{
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  
}