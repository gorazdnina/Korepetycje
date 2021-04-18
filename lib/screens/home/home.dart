import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final AuthService _auth = AuthService();

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Korepetycje',
      style: optionStyle,
    ),
    Text(
      'Kalendarz',
      style: optionStyle,
    ),
    Text(
      'Ulubione',
      style: optionStyle,
    ),
    Text(
      'Koszyk',
      style: optionStyle,
    ),
  ];

  //tu chyba baze danych trzeba
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Color(0xFFECB6B6),
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
        ),
      ],
    },
  );

  DateTime _currentDate = new DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String dropdownValue = 'Wszystko';
  Widget _menuScreen() {
    return Column(
      children: <Widget>[
        Text(
            "Wybierz kategorie: "
        ),
        _dropDownCategory(),

      ],
    );
  }

  Widget _dropDownCategory(){
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Color(0xFF212121)),
      underline: Container(
        height: 2,
        color: Color(0xFFECB6B6),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Wszystko', 'Matematyka', 'Polski', 'Angielski', 'Fizyka', 'Chemia', 'Inne']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _calendarScreen() {
    return Container(
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        selectedDayButtonColor: Color(0xFFECB6B6),
        selectedDayBorderColor: Color(0xFFECB6B6),
        selectedDayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.day == 15) {
            return Center(
              child: Icon(Icons.local_airport),
            );
          } else {
            return null;
          }
        },
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _selectScreen(){
    if(_selectedIndex == 0) return _menuScreen();
    else return _calendarScreen();
  }

  Widget _menuMainScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ogłoszenie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalendarz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Ulubione',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Koszyk',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xFF3B3A3A),
        selectedItemColor: Color(0xFFECB6B6),
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tlo.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _widgetOptions.elementAt(_selectedIndex),
                      /*Text(
                        'Korepetycje',
                        style: TextStyle(
                          color: Color(0xFF393939),
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                      SizedBox(height: 30.0),
                      _selectScreen(),
                      //_calendarScreen(),
                      //_widgetOptions.elementAt(_selectedIndex),
                    ],
                  ),

                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ogłoszenie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalendarz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Ulubione',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Koszyk',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 30,
        unselectedItemColor: Color(0xFF3B3A3A),
        selectedItemColor: Color(0xFFECB6B6),
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text('Korepetycje'),
        backgroundColor: Color(0xFFECB6B6),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label:  Text('logout'),
            onPressed: () async{
              await _auth.signOut(); //tu trzeba dać mozliwość edycji profilu
            },
          )
        ],
      ),
    );
  }
}