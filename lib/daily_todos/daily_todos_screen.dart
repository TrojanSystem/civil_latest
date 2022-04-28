import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:example/daily_todos/shop_list/shop_screen.dart';
import 'package:example/daily_todos/todo_list/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyTodosScreen extends StatefulWidget {
  const DailyTodosScreen({Key key}) : super(key: key);

  @override
  State<DailyTodosScreen> createState() => _DailyTodosScreenState();
}

class _DailyTodosScreenState extends State<DailyTodosScreen> {
  int _selectedIndex = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> page = const [
    ShopList(),
    TodoList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blue[800],
        items: const [
          TabItem(
            icon: FontAwesomeIcons.cartShopping,
            title: 'ShopList',
          ),
          TabItem(
            icon: FontAwesomeIcons.tasks,
            title: 'TaskList',
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
