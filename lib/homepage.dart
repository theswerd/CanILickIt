import 'package:CanILickIt/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (c,i) {
        switch (i) {
          case 0:
            return Map();
          default:
            return Container();
        }
      },
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            title: Text(
              "Map",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            title: Text(
              "History",
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              title: Text(
                "Settings",
              )),
        ],
      ),
    );
  }
}
