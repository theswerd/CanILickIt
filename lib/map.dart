import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
//import 'package:settings_ui/settings_ui.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //Location.instance.getLocation()

  SettingsPage settingsPage;
  Set<Marker> markers;
  @override
  void initState() {
    super.initState();
    this.settingsPage = SettingsPage(
      placesIHaveLicked: true,
      placesIHaventLicked: false,
      placesOtherPeopleHaveLicked: true,
    );
    this.markers = {};
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Map",
        ),
        trailing: Material(
          child: IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (v, s) {
                  return this.settingsPage;
                },
                useRootNavigator: true,
              );
            },
          ),
          type: MaterialType.transparency,
        ),
      ),
      child: PlatformMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: this.markers,
        onMapCreated: (controller) async {
          animateToPerson(controller);
          addLocalStorageLicks();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            51.472297579450526,
            -100.6941271464278,
          ),
        ),
      ),
    );
  }

  Future<void> animateToPerson(PlatformMapController controller) async {
    LocationData location = await Location.instance.getLocation();
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          location.latitude,
          location.longitude,
        ),
        12,
      ),
    );
  }

  Future<void> addLocalStorageLicks() async {
    LocalStorage localStorage = LocalStorage("licks.json");
    await localStorage.ready;
    List licks = localStorage.getItem('licks') ??
        [
          {'lat': 37.762009, 'long': -122.434677, 'licker': 'you','object':"wall",}
        ];
    for (Map lick in licks) {
      setState(
        () {
          this.markers.add(
                Marker(
                  markerId: MarkerId(this.markers.length.toString()),
                  position: LatLng(
                    lick['lat'],
                    lick['long'],
                  ),
                  infoWindow: InfoWindow(
                    title: lick['licker'] == 'you'
                        ? "You licked something here"
                        : "Someone else licked something here",
                    snippet: (lick['licker'] == 'you'? "You": "Someone") + " licked a "+lick['object']
                  ),
                ),
              );
        },
      );
    }
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key key,
    @required this.placesIHaveLicked,
    @required this.placesOtherPeopleHaveLicked,
    @required this.placesIHaventLicked,
  }) : super(key: key);

  bool placesIHaveLicked;
  bool placesOtherPeopleHaveLicked;
  bool placesIHaventLicked;

  bool get haveLicked => this.placesIHaveLicked;
  bool get haventLicked => this.placesIHaveLicked;
  bool get otherPeopleLicked => this.placesOtherPeopleHaveLicked;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        children: [
          CupertinoNavigationBar(
            middle: Text("Filter"),
            leading: Container(),
            trailing: Material(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () => Navigator.pop(
                  context,
                ),
              ),
              type: MaterialType.transparency,
            ),
          ),
          Container(
            height: 1000,
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: "What would you like to see?",
                  tiles: [
                    SettingsTile.switchTile(
                      title: "Things I have licked",
                      onToggle: (v) {
                        setState(() {
                          widget.placesIHaveLicked = v;
                        });
                      },
                      switchValue: this.widget.placesIHaveLicked,
                    ),
                    SettingsTile.switchTile(
                      title: "Things other people licked",
                      onToggle: (v) {
                        setState(() {
                          widget.placesOtherPeopleHaveLicked = v;
                        });
                      },
                      switchValue: this.widget.placesOtherPeopleHaveLicked,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
