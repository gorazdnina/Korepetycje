import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';

class Home extends StatelessWidget{
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label:  Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}