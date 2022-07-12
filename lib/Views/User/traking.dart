import 'dart:async';

import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  State<Tracking> createState() => TrackingState();
}

class TrackingState extends State<Tracking> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng destination = LatLng(-6.7666642, 39.231338),
      sourceLocation = LatLng(-6.7913044, 39.2296587);

  String sourceAddress = '', currentAddress = '', destinationIconAddress = '';

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    sourceAddress =
        getAddress(sourceLocation.latitude, sourceLocation.longitude);
    destinationIconAddress =
        getAddress(destination.latitude, destination.longitude);
    setCustomMarkerIcon();

    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading...."))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'Current Point ',
                    snippet: currentAddress,
                  ),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  icon: sourceIcon,
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'Frank Galos',
                    snippet: sourceAddress,
                  ),
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  icon: destinationIcon,
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'Destination Point ',
                    snippet: destinationIconAddress,
                  ),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: OColors.primary,
                  width: 6,
                ),
              },
            ),
    );
  }

  getAddress(double? lat, double? lang) {
    print("Address_");
    return _getAddress(lat, lang).then((value) => print(value));
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(52.2165157, 6.9437819);

    return "${placemarks[0].country}, ${placemarks[0].street}";
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylines = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylines.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {
        polylineCoordinates.addAll(polylines);
      });
    }
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
        });
      },
    );

    _controller.future.then((controller) {
      location.onLocationChanged.listen(
        (newLoc) {
          setState(() {
            currentLocation = newLoc;
            currentAddress = getAddress(newLoc.latitude, newLoc.longitude);
          });

          print("Location");
          print(
              newLoc.latitude!.toString() + "," + newLoc.longitude!.toString());

          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 13.5,
                target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!,
                ),
              ),
            ),
          );
        },
      );
    });

    print("Location---");
    print(currentLocation);
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/Pin_source.png")
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/Pin_destination.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/Badge.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }
}
