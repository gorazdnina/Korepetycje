import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:flutter_app2/models/userr.dart';

class DataBaseService{

  final String uid;
  DataBaseService({this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String phone, String email) async{
    return await brewCollection.doc(uid).set({
      'name' : name,
      'phone' : phone,
      'email' : email,
    });
  }

  List<Useerr> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Useerr(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        phone: doc.data()['phone'] ?? '',
      );
    }).toList();
  }

  Stream<List<Useerr>> get brews {
    return brewCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //userdata from snapchot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phone: snapshot.data()['phone']
    );
  }

}