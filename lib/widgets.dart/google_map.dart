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
  GoogleMapController? mapController;

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  Location location = Location();
  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
  }

  void _currentLocation() async {
    LocationData? currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      print("failr");
    }

    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
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
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.black,
        child: IconButton(
          onPressed: () {
            _currentLocation();
          },
          icon: Icon(Icons.home),
        ),
      ),
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
        ],
      ),
    );
  }
}
