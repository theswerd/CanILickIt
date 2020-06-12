import 'package:CanILickIt/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // home: HomePage(),

      onGenerateRoute: (settings) {
        return MaterialWithModalsPageRoute(
          settings: settings,
          builder: (
            context,
          ) =>
              HomePage(),
        );
      },
    );
  }
}
