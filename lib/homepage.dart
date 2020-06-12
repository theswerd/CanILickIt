import 'package:CanILickIt/canyoulickit.dart';
import 'package:CanILickIt/history.dart';
import 'package:CanILickIt/map.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  CupertinoTabController tabController = CupertinoTabController();

  @override
  void initState() {
    super.initState();
    this.tabController.addListener(() async{
      if (tabController.index == 2) {
        List<CameraDescription>  cameras = await availableCameras();

        showCupertinoModalBottomSheet(
          context: context,
          builder: (c, s) => CanYouLickIt(cameras: cameras,),
        );

        tabController.index = currentIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: this.tabController,
      tabBuilder: (c, i) {
        currentIndex = i == 2 ? currentIndex : i;
        switch (currentIndex) {
          case 0:
            return MapPage();
          case 1:
            return History();
          default:
            return Container();
        }
      },
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Text(
              "🗺️",
              textScaleFactor: 3,
            ),
            title: Text(
              "Map",
            ),
          ),
          BottomNavigationBarItem(
            icon: Text(
              "⌛",
              textScaleFactor: 3,
            ),
            title: Text(
              "History",
            ),
          ),
          BottomNavigationBarItem(
              icon: Text(
                "👅",
                textScaleFactor: 3,
              ),
              title: Text(
                "Can you lick it?",
              )),
        ],
      ),
    );
  }
}
