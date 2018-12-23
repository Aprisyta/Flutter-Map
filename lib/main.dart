import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Demo"),
      ),
      resizeToAvoidBottomPadding: true,
      body: MapsDemo(),
    ),
  ));
}

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  GoogleMapController mapController;
  LatLng workCoordinates = LatLng(17.456348, 78.368109);
  LatLng xyzCoordinates = LatLng(18.456348, 79.368109);

  @override
  void initState() {
    super.initState();
    askPermission();
//    bool isOpened = await PermissionHandler().openAppSettings();
//    bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(PermissionGroup.contacts);
  }

  askPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    checkPermission();
  }

  checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.unknown ||
        permission == PermissionStatus.denied) {
      askPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: 600.0,
          child: GoogleMap(
            
            onMapCreated: _onMapCreated,
            options: GoogleMapOptions(
              mapType: MapType.hybrid,
              cameraPosition: CameraPosition(target: LatLng(0, 0)),
              myLocationEnabled: true,
              compassEnabled: true,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: workCoordinates,
                        zoom: 19.0,
                        tilt: 20.0,
                      ),
                    )
                );
              },
              child: Icon(
                Icons.work,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(LatLngBounds(southwest: workCoordinates, northeast: xyzCoordinates), 20.0),
                );
              },
              child: Icon(
                Icons.directions,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                mapController.addMarker(
                  MarkerOptions(
                    draggable: true,
                    consumeTapEvents:
                  )
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
