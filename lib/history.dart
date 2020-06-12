import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("History"),
      ),
      child: Container(),
    );
  }
}