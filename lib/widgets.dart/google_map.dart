import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location/location.dart';

class MyGoogleMap extends StatefulWidget {
  static const String routeName = '/google-map';
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  static final LatLng _kMapCenter = LatLng(31.524123, 34.443486);

  static final LatLng _kMapBloodCenter =
      LatLng(31.52306049379596, 34.437954735976035);
  GoogleMapController? mapController;
  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  Location location = Location();
  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
  }

  void _bloodBankLocation() async {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: _kMapBloodCenter,
        zoom: 17.0,
      ),
    ));
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("hospital1"),
          position: _kMapCenter,
          infoWindow: InfoWindow(title: 'hospital'.tr())),
      Marker(
          markerId: MarkerId("hospital2"),
          position: _kMapBloodCenter,
          infoWindow: InfoWindow(title: 'bankBlood'.tr())),
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kInitialPosition,
            buildingsEnabled: true,
            myLocationButtonEnabled: true,
            indoorViewEnabled: true,
            zoomControlsEnabled: true,
            markers: _createMarker(),
            trafficEnabled: true,
            onMapCreated: _onMapCreated,
            padding: EdgeInsets.only(
              top: 40.0,
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: ElevatedButton(
              onPressed: () {
                _bloodBankLocation();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.red[400])),
              child: Row(
                children: [
                  Icon(Icons.bloodtype),
                  Text(
                    "${'goto'.tr()} ${'bankBlood'.tr()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
