import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rapid_note/screens/home_screen/home_screen.dart';
import 'package:rapid_note/screens/male_or_female_screen/male_or_female_screen.dart';
import 'package:rapid_note/screens/text_to_voice_screen/text_to_voice.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routeName = '/navigation';
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TextToVoice(),
    MaleOrFemale(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffFF8080),
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.accessibility,
              color: Color(0xffFD5D5D),
            ),
            label: "Elders Care",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_outdoor_rounded,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.camera_outdoor,
              color: Color(0xffFD5D5D),
            ),
            label: "Guardians",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.handshake_rounded,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.handshake,
              color: Color(0xffFD5D5D),
            ),
            label: "Relatives",
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
