import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/screens/home/appbar.dart';

class DetailPage extends StatefulWidget {

  final Product product;
  DetailPage({this.product});
  @override 
  _DetailPageState createState()=> _DetailPageState();
  // final Lesons leson;
  // DetailPage({this.leson});
  // @override 
  // _DetailPageState createState()=> _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
    @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: BaseAppBar(
          title: Text('title'),
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
        ),
      body: Container(
      child: Card(
        child: ListTile(
          title: Text(widget.product.name),
          subtitle: Text(widget.product.descryption),
        ),
      ),
    ),
    );
  }
  // @override 
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: BaseAppBar(
  //         title: Text('title'),
  //         appBar: AppBar(),
  //         widgets: <Widget>[Icon(Icons.more_vert)],
  //       ),
  //     body: Container(
  //     child: Card(
  //       child: ListTile(
  //         title: Text(widget.leson.name),
  //         subtitle: Text(widget.leson.descryption),
  //       ),
  //     ),
  //   ),
  //   );
  // }
}