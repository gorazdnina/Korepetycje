import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/providers/cartitemprovider.dart';
import 'package:flutter_app2/screens/home/appbar.dart';
import 'package:provider/provider.dart';

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


  Widget tutorDataSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
            leading: CircleAvatar(
              child: Icon(
                  Icons.account_circle, ////TODO add user profile photo
                  color: Colors.white,
                  size: 50,
              ),
              radius: 25,
              backgroundColor: Color(0xFFECB6B6),
            ),
              title: Text("widget.tutor.name"), ////TODO connect to database
              subtitle: Text("widget.tutor.level"), //moze tu poziom wiedzy nauczyciela np student lub nauczyciel////TODO
              onTap: (){
                print("Tutor desc pagae here"); ////TODO connect to database
                //return Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPage(product: product,)));
              }
          ),
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Text('4.5'), ////TODO add tutor rate
        ],
      ),
    );
  }

  Widget descriptionSection(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.all(8),
      child:  Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        widget.product.descryption,
        softWrap: true,
      ),
      ),
    );
  }

  Widget buttonSection(BuildContext context){

    final cartItemProvider = Provider.of<CartItemProvider>(context);
    final user = Provider.of<Userr>(context);

    return Container(
      padding: const EdgeInsets.all(32),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color(0xFFECB6B6),
          child: Text(
            'ADD TO CART',
            style: TextStyle(
              color: Color(0xFFFDFDFD),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed:() async{
            cartItemProvider.changequantity("1");
            cartItemProvider.changeproductId(widget.product.productId);
            cartItemProvider.changeuid(user.uid);
            cartItemProvider.saveCartItem();
            Navigator.of(context).pop();
          } ,
        ),
      ),
    );
  }

  Widget titleSection(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              /*1*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.category, ////TODO maybe better level of education?
                    style: TextStyle(
                      color: Colors.grey[500],

                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.attach_money,
              //color: Colors.red[500],
            ),
            Text(
              widget.product.price.toString() + ' PLN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
  }

  Widget detailSection(BuildContext context){
     return Container(
       padding: const EdgeInsets.all(32),
       child: Row(
         children: [
           Expanded(
             /*1*/
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 /*2*/
                 Container(
                   padding: const EdgeInsets.only(bottom: 8),
                   child: Text(
                     'Dane kontaktowe',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
                 Text(
                   'tel.:' + ' ' + '666213700',//'widget.product.tutorId.phone', ////TODO add new field: tutorId to database and new table: tutor -> phone
                   style: TextStyle(
                     color: Colors.grey[500],
                   ),
                 ),
                 Text(
                   'email:' + ' ' + 'alajestem@gmail.com',//'widget.product.tutorId.email', ////TODO add new field: tutorId to database and new table: tutor -> email
                   style: TextStyle(
                     color: Colors.grey[500],
                   ),
                 ),
               ],
             ),
           ),
           /*3*/
           Expanded(
             /*1*/
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 /*2*/
                 Container(
                   padding: const EdgeInsets.only(bottom: 8),
                   child: Text(
                     'Lokalizacja',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
                 Text(
                   'Kandersteg, Switzerland',//'widget.product.tutorId.localization', ////TODO add new field: tutorId to database and new table: tutor -> localization
                   style: TextStyle(
                     color: Colors.grey[500],
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
  }

   // @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: BaseAppBar(
          title: Text('title'),
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
        ),
      body: Container(
        child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children:<Widget> [
            // Image.asset(
            //   'assets/images/banner.jpg',
            //   fit: BoxFit.cover,
            // ),
            titleSection(context),
            descriptionSection(context),
            detailSection(context),
            buttonSection(context),
            tutorDataSection(context),
          ],
          ),
        ),
      // child: Card(
      //   child: ListTile(
      //     title: Text(widget.product.name),
      //     subtitle: Text(widget.product.descryption),
      //   ),
      // ),
      ),
    );
  }

}