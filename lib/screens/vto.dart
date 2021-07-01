import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

const apikey =
    "ef215fa9b71cef7c233a543b77cf39f2647e4850cf9a3e67b42e11501b64f25291784343a73ed6db";

class Vto extends StatefulWidget {
  @override
  _VtoState createState() => _VtoState();
}

class _VtoState extends State<Vto> {
  CameraDeepArController cameraDeepArController;
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
                            cameraDeepArController.changeMask(7),
                            // if (effectCount == 7) {effectCount = 0},
                            // effectCount++
                          })))
        ],
      )),
    );
  }
}
