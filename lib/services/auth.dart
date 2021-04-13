import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/models/userr.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj base on FirebaseUser
  Userr _userFromFireBaseUser(User user){
    return user!=null ? Userr(uid: user.uid) :null;
  }

  //auth change user stream
  Stream<Userr> get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // sing in anon
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
    print(e.toString());
    return null;
    }
  }
  // 
}