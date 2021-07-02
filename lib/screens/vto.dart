// ignore: import_of_legacy_library_into_null_safe
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

const apikey =
    "bd79c7972493126948c6ac71a963d4cd6252fd3944ceeb72007f4cc9cce83ede559dd61bfe5185a2";

class Vto extends StatefulWidget {
  @override
  _VtoState createState() => _VtoState();
}

class _VtoState extends State<Vto> {
  CameraDeepArController? cameraDeepArController;
  int effectCount = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          CameraDeepAr(
              onCameraReady: (isReady) {
                setState(() {});
              },
              onImageCaptured: (path) {
                setState(() {});
              },
              onVideoRecorded: (path) {
                setState(() {});
              },
              androidLicenceKey: apikey,
              iosLicenceKey: apikey,
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              }),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: FloatingActionButton(
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.navigate_next),
                      onPressed: () => {
                            cameraDeepArController?.changeMask(1),
                            // if (effectCount == 7) {effectCount = 0},
                            // effectCount++
                          })))
        ],
      )),
    );
  }
}
