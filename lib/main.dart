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

  @override
  void initState() {
    super.initState();
    checkPermission();
//    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
//    bool isOpened = await PermissionHandler().openAppSettings();
//    bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(PermissionGroup.contacts);
  }

  checkPermission () async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          mapType: MapType.hybrid,
          cameraPosition: CameraPosition(target: LatLng(0, 0)),
          myLocationEnabled: true,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }
}