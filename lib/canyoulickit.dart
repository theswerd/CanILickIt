import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CanYouLickIt extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CanYouLickIt({Key key, @required this.cameras}) : super(key: key);

  @override
  _CanYouLickItState createState() => _CanYouLickItState();
}

class _CanYouLickItState extends State<CanYouLickIt> {
  CameraController controller;
  CameraDescription description;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          CupertinoNavigationBar(
            leading: Container(),
            trailing: Material(
              type: MaterialType.transparency,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () => Navigator.pop(
                  context,
                ),
              ),
            ),
            middle: Text("Can you lick it?"),
          ),
          () {
            if (controller == null) {
              return Expanded(
                child: Center(
                  child: Text(
                    "Your device doesn't have any cameras.",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (!controller.value.isInitialized) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(
                  controller,
                ),
              );
            }
          }()
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
