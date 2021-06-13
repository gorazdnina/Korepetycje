import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/cartitem.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/providers/productprovider.dart';
import 'package:flutter_app2/screens/home/appbar.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:provider/provider.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DataBaseService _db = DataBaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              createHeader(),
              createSubTitle(),
              createCartList(context),
              footer(context)
            ],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "Cena",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          //Utils.getSizedBox(height: 8),
          RaisedButton(
            onPressed: () {
             /* Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CheckOutPage()));*/
              print('go checkout page??');
            },
            color: Color(0xFFECB6B6),
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //Utils.getSizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "KOSZYK",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total" +  "cart.length" + "lessons", // attach length of cart table
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  

  createCartList(BuildContext context) {
    final items = Provider.of<List<CartItem>>(context);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount:items.length ?? 0,
      itemBuilder: (context, index) {
        return createCartListItem(items[index]); //createCartListItem(cart: cart[index]);
      },

    );
  }

  dropItemFromCart(){
      print("delete item from cart");
      //drop item from database
  }


  int count = 1; // do wywalenia
  int pricePerHour = 30; // do wywalenia






 createCartListItem(CartItem cartitem) {
    String text = cartitem.productId;
     return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Product').where("productId",isEqualTo: cartitem.productId).snapshots(),
        builder: (context, snapshot){
        if (!snapshot.hasData) return const Center(
         child: const CupertinoActivityIndicator(),
        );
        return Stack(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: <Widget>[
              /* jakbysmy chcieli zzdjjj do kodu
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: AssetImage("images/shoes_1.png"))),
              ),*/
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          
                          document.data()['category'],
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //Utils.getSizedBox(height: 6),
                      Text(
                        "$text",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Data: " + "date.fromDatabase",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Godzina: " + "hour.fromDatabase",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                             document.data()['price'].toString() + " PLN", //price per hour * count of hour
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 24,
                                      color:Color(0xFFECB6B6),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        count--; //decrease hour of lessons from database
                                      });
                                    },
                                  ),

                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12, right: 12, left: 12),
                                    alignment: Alignment.center,
                                    child: Text(
                                      count.toString(),
                                      style:
                                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        size: 24,
                                        color: Color(0xFFECB6B6)),
                                    onPressed: () {
                                      setState(() {
                                        count++; //add hour of lessons to database
                                      });
                                    },
                                  ),

                                ],
                              ),
                            )
                          ],
                )
            ),
            ],
            ),
            ),
            flex: 100,
            ),
            ],
            ),
            );
          }).toList(),
         );  
      }
     );
  }









  createCartListItemm(CartItem cartitem) {
    String text = cartitem.productId;
     return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Product').where("productId",isEqualTo: cartitem.productId).snapshots(),
        builder: (context, snapshot){
        if (!snapshot.hasData) return const Center(
         child: const CupertinoActivityIndicator(),
        );
        return Stack(
          
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              /* jakbysmy chcieli zzdjjj do kodu
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: AssetImage("images/shoes_1.png"))),
              ),*/
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          
                          "Kategoria",
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      //Utils.getSizedBox(height: 6),
                      Text(
                        "$text",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Data: " + "date.fromDatabase",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Godzina: " + "hour.fromDatabase",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              (pricePerHour*count).toString() + "PLN", //price per hour * count of hour
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 24,
                                      color:Color(0xFFECB6B6),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        count--; //decrease hour of lessons from database
                                      });
                                    },
                                  ),

                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12, right: 12, left: 12),
                                    alignment: Alignment.center,
                                    child: Text(
                                      count.toString(),
                                      style:
                                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        size: 24,
                                        color: Color(0xFFECB6B6)),
                                    onPressed: () {
                                      setState(() {
                                        count++; //add hour of lessons to database
                                      });
                                    },
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: IconButton(
              padding: EdgeInsets.only(right: 5, top: 0),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
              alignment: Alignment.center,
              onPressed: () {
                setState(() {
                  dropItemFromCart();
                  //print("delete item from cart"); //delete item from cart in database
                });
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(0xFFECB6B6),
            ),
        )
    )
    ],


    );  
        }
     );




    // return Stack(
    //   children: <Widget>[
    //     Container(
    //       margin: EdgeInsets.only(left: 16, right: 16, top: 16),
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.all(Radius.circular(16))),
    //       child: Row(
    //         children: <Widget>[
    //           /* jakbysmy chcieli zzdjjj do kodu
    //           Container(
    //             margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
    //             width: 80,
    //             height: 80,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(14)),
    //                 color: Colors.blue.shade200,
    //                 image: DecorationImage(
    //                     image: AssetImage("images/shoes_1.png"))),
    //           ),*/
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.max,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Container(
    //                     padding: EdgeInsets.only(right: 8, top: 4),
    //                     child: Text(
    //                       "Kategoria",
    //                       maxLines: 2,
    //                       softWrap: true,
    //                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                   //Utils.getSizedBox(height: 6),
    //                   Text(
    //                     "$text",
    //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     "Data: " + "date.fromDatabase",
    //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     "Godzina: " + "hour.fromDatabase",
    //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //                   ),
    //                   Container(
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: <Widget>[
    //                         Text(
    //                           (pricePerHour*count).toString() + "PLN", //price per hour * count of hour
    //                           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.end,
    //                             children: <Widget>[
    //                               IconButton(
    //                                 icon: const Icon(
    //                                   Icons.remove,
    //                                   size: 24,
    //                                   color:Color(0xFFECB6B6),
    //                                 ),
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     count--; //decrease hour of lessons from database
    //                                   });
    //                                 },
    //                               ),

    //                               Container(
    //                                 color: Colors.grey.shade200,
    //                                 padding: const EdgeInsets.only(
    //                                     top: 12, bottom: 12, right: 12, left: 12),
    //                                 alignment: Alignment.center,
    //                                 child: Text(
    //                                   count.toString(),
    //                                   style:
    //                                   TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                               IconButton(
    //                                 icon: const Icon(Icons.add,
    //                                     size: 24,
    //                                     color: Color(0xFFECB6B6)),
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     count++; //add hour of lessons to database
    //                                   });
    //                                 },
    //                               ),

    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             flex: 100,
    //           )
    //         ],
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: Container(
    //         width: 24,
    //         height: 24,
    //         alignment: Alignment.center,
    //         margin: EdgeInsets.only(right: 10, top: 8),
    //         child: IconButton(
    //           padding: EdgeInsets.only(right: 5, top: 0),
    //           icon: const Icon(
    //             Icons.close,
    //             color: Colors.white,
    //             size: 25,
    //           ),
    //           alignment: Alignment.center,
    //           onPressed: () {
    //             setState(() {
    //               dropItemFromCart();
    //               //print("delete item from cart"); //delete item from cart in database
    //             });
    //           },
    //         ),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(4)),
    //           color: Color(0xFFECB6B6),
    //         ),
    //     )
    // )],
    // );
  }
}
