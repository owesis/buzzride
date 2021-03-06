import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:buzzride/Models/TimeTravel.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  State<Tracking> createState() => TrackingState();
}

class TrackingState extends State<Tracking> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? destination = LatLng(-6.7666642, 39.231338),
      sourceLocation = LatLng(-6.8173163, 39.2216505);

  double earthRadius = 6371000;
  String duration = '', distance = '';

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
    getAddress(sourceLocation!.latitude, sourceLocation!.longitude)
        .then((value) => sourceAddress = value);
    getAddress(destination!.latitude, destination!.longitude)
        .then((value) => destinationIconAddress = value);
    setCustomMarkerIcon();
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
                    title: 'Frank Galos',
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
                  position: sourceLocation!,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  icon: destinationIcon,
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'Destination Point ',
                    snippet: destinationIconAddress,
                  ),
                  position: destination!,
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

  //Calculating the distance between two points
  getDistance() async {
    var ad = Geolocator.distanceBetween(
        sourceLocation!.latitude,
        sourceLocation!.longitude,
        destination!.latitude,
        destination!.longitude);

    print(ad);

    print("Distances....");
    TimeTravel travel = await TimeTravel().getDistance(
        lat1: sourceLocation!.latitude.toString(),
        long1: sourceLocation!.longitude.toString(),
        lat2: destination!.latitude.toString(),
        long2: destination!.longitude.toString());

    double dist = _coordinateDistance(
        sourceLocation!.latitude,
        sourceLocation!.longitude,
        destination!.latitude,
        destination!.longitude);

    setState(() {
      duration = travel.time!;
      distance = dist.toStringAsFixed(2) + " Km";
    });
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<String> getAddress(double? lat, double? lang) async {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(lat!, lang!);

    geocoding.Placemark place = placemarks[0];
    return "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
  }

  Future<String> getCoordinatesFromAddress(String address) async {
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(address);

    print(locations);
    return "";
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
          sourceLocation = LatLng(location.latitude!, location.longitude!);

          getPolyPoints();
          getDistance();
        });
      },
    );

    _controller.future.then((controller) {
      location.onLocationChanged.listen(
        (newLoc) {
          getAddress(newLoc.latitude, newLoc.longitude)
              .then((value) => setState(() {
                    currentAddress = value;
                    currentLocation = newLoc;
                  }));

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

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylines = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destination!.latitude, destination!.longitude),
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
