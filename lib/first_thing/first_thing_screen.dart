import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:example/first_thing/attendance/attendanceList.dart';
import 'package:example/first_thing/store/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstThingScreen extends StatefulWidget {
  const FirstThingScreen({Key key}) : super(key: key);

  @override
  State<FirstThingScreen> createState() => _FirstThingScreenState();
}

class _FirstThingScreenState extends State<FirstThingScreen> {
  int _selectedIndex = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> page = [
    const AttendanceList(),
    StorageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blue[800],
        items: const [
          TabItem(
            icon: FontAwesomeIcons.tasks,
            title: 'Attendance',
          ),
          TabItem(
            icon: FontAwesomeIcons.store,
            title: 'Store',
          ),
        ],
        initialActiveIndex: _selectedIndex, //optional, default as 0
        onTap: (int i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
    );
  }
}
