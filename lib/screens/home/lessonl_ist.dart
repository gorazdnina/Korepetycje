


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class LesonList extends StatefulWidget{
  @override 
  _LesonListState createState() => _LesonListState();
}

class _LesonListState extends State<LesonList>{
  @override 
  Widget build(BuildContext context){
    
    final lesons = Provider.of<List<Lesons>>(context);

    return ListView.builder(
      itemCount: lesons.length ?? 0,
      itemBuilder: (context,index){
        return LesonTitle(lesons: lesons[index]);
      },
    );
  }
}

class LesonTitle  extends StatelessWidget {

  final Lesons lesons;
  LesonTitle({this.lesons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pink[100],
          ),
          title: Text(lesons.name),
          subtitle: Text("Cena: ${lesons.price.toString()}zł"),
        ),
      ), 
    );
  }
}