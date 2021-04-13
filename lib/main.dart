// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/authenticate/login_screen.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';
import 'package:flutter_app2/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/userr.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr>.value(
      value: AuthService().user,
      // value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

    // return StreamProvider<Userr>.value(
    //   value:AuthService().user,
    //   child: MaterialApp(
    //     title: 'Flutter Login UI',
    //     debugShowCheckedModeBanner: false,
    //     home: LoginScreen(),
    //   ),
    // );
/*
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Szugar Kalkulejtor',
      home: SugarButton(),
      //home: RandomWorld(),
    );
  }
}

class SugarButton extends StatefulWidget {
  @override
  _SugarButtonState createState() => _SugarButtonState();
}

class _SugarButtonState extends State<SugarButton> {
  int _count = 0;
  int _weight = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szugar Kalkulejtor'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Center(
        child:  Text('You have pressed the button $_count times.')
        /*  Image.asset(
          'assets/images/sugarcalculator.png',
          fit: BoxFit.cover,
          height: 250,
        ),
         */
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: Image.asset(
          'assets/images/sugarcalculator.png',
          fit: BoxFit.cover,
          height: 250,
        ),
          backgroundColor: Colors.transparent,
      ),
      // backgroundColor: Colors.pinkAccent.shade100,
    );
  }
}


class RandomWorld extends StatefulWidget {
  @override
  _RandomWorldState createState() => _RandomWorldState();
}

class _RandomWorldState extends State<RandomWorld> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
*/