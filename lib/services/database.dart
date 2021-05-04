import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/models/useerr.dart';

class DataBaseService{

  final String uid;
  DataBaseService({this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('users');
  final DocumentReference userdata = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid);

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

}