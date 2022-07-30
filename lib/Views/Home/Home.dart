import 'dart:async';

import 'package:address_search_field/address_search_field.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Drawer/drawer.dart';
import 'package:buzzride/Views/User/traking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../Util/Util.dart';
import '../profile/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController destinationController = TextEditingController(),
      currentLocationInput = TextEditingController();
  String location = '', currentAddress = '';
  LocationData? currentLocation, sourceLocation;
  List<LatLng> cars = [
    LatLng(-6.7731, 39.2196),
    LatLng(-6.7669, 39.2265),
    LatLng(-6.7715, 39.2287),
    LatLng(-6.8166, 39.2208),
    LatLng(-6.8163, 39.2229),
    LatLng(-6.8163, 39.2229),
  ];

  Set<Marker> markers = Set();

  // ignore: prefer_typing_uninitialized_variables
  late final _drawerController;

  bool isSwahili = false, isVisibleDrawer = true, r = false;
  int display = 0;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor carsIcon = BitmapDescriptor.defaultMarker;

  List<Widget> menus = [
    ListTile(
      onTap: () => () {},
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(color: Colors.blueAccent),
        child: Icon(Icons.category, color: OColors.whiteFade),
      ),
      title: Text(
        "Home",
        style: TextStyle(color: OColors.white, fontSize: 16),
      ),
    ),
  ];

  final routeProvider =
      ChangeNotifierProvider<RouteNotifier>((ref) => RouteNotifier());

  late Address destinationAddress;
  final geoMethods = GeoMethods(
    googleApiKey: google_api_key,
    language: 'sw',
    countryCode: 'tz',
    countryCodes: ['tz'],
    country: 'Tanzania',
    city: 'Dar es salaam',
  );

  SpinKitFadingFour spinkit = const SpinKitFadingFour(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    _drawerController = ZiDrawerController();

    geoMethods.autocompletePlace(query: 'place streets or reference');
    // geoMethods.geoLocatePlace(coords: Coords(-6.82349, 39.26951));

    // TODO: implement initState
    super.initState();
  }

  menuCategories() {
    setState(() {
      menus.add(Container(
        // height: 250,   // Screen OverFlow 45 pixer
        height: MediaQuery.of(context).size.height / 2.8,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(),

            // User Avater
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Profile()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Image(
                          image: AssetImage('assets/images/user.png'),
                        ),
                      ),
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Frank Galos",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: OColors.white.withOpacity(.9)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Text(
                "+255 743 500 123",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: OColors.whiteFade.withOpacity(.6)),
              ),
            )
          ],
        ),
      ));

      menus.add(Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.bottomCenter,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(1.4),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              color: OColors.borderColor.withOpacity(.1),
            ),
            ListTile(
              onTap: () => Pager(context, const MyHomePage()),
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.home_filled, color: OColors.whiteFade),
              ),
              title: Text(
                "Home",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
              contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 15),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.history, color: OColors.whiteFade),
              ),
              title: Text(
                "Travel History",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
              contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 15),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.notifications_outlined,
                    color: OColors.whiteFade),
              ),
              title: Text(
                "Notifications",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
              contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 15),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.settings, color: OColors.whiteFade),
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
              contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 15),
            )
          ],
        ),
      ));

      menus.add(const Spacer());

      menus.add(DefaultTextStyle(
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white54,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Designed & Developed with ',
                style: TextStyle(
                    color: OColors.white.withOpacity(.4),
                    fontWeight: FontWeight.w800),
              ),
              Icon(
                Icons.favorite,
                color: Colors.white.withOpacity(.6),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                child: Text(
                  "by OWESIS",
                  style: TextStyle(
                      color: OColors.white.withOpacity(.4),
                      fontWeight: FontWeight.w800),
                ),
                onTap: () => launchURL("https://owesis.com"),
              )
            ],
          ),
        ),
      ));
    });
  }

  getCarsPosition() {
    print("object................");
    setState(() {
      markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        icon: currentLocationIcon,
        infoWindow: InfoWindow(
          //popup info
          title: 'Frank Galos',
          snippet: currentAddress,
        ),
        position: LatLng(sourceLocation!.latitude!, sourceLocation!.longitude!),
      ));
    });

    for (var i = 0; i <= cars.length - 1; i++) {
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId("carsLocation"),
          icon: carsIcon,
          infoWindow: InfoWindow(
            //popup info
            title: 'Frank Galos',
            snippet: currentAddress,
          ),
          position: cars[i],
        ));
      });
    }
  }

  Widget? _menuButton(BuildContext context) {
    setState(() {
      menus.clear();
      menuCategories();
    });

    return SizedBox(
      child: InkWell(
        child: isVisibleDrawer
            ? Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: OColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OColors.white,
                      ),
                    ),
                    Container(
                      height: 3,
                      margin: const EdgeInsets.only(top: 3),
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: OColors.white),
                    ),
                    Container(
                      height: 3,
                      margin: EdgeInsets.only(top: 4),
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OColors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Icon(
                Icons.cancel,
                size: 32,
                color: OColors.buttonColor,
              ),
        onTap: () {
          _drawerController.showDrawer();
          setState(() {
            if (_drawerController.value.visible) {
              isVisibleDrawer = false;
            } else {
              isVisibleDrawer = true;
            }
          });

          _drawerController.addListener(() {
            setState(() {
              if (_drawerController.value.visible) {
                isVisibleDrawer = false;
              } else {
                isVisibleDrawer = true;
              }
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawerer(
        backdropColor: OColors.whiteFade,
        controller: _drawerController,
        drawer: SafeArea(
          child: Container(
            alignment: Alignment.bottomCenter,
            color: OColors.primary,
            child: ListTileTheme(
              textColor: OColors.white,
              iconColor: OColors.primary,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: menus,
                ),
              ),
            ),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(alignment: Alignment.center, children: [
              currentLocation == null
                  ? const Center(child: Text("Loading...."))
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 13.5,
                      ),
                      markers: markers,
                      liteModeEnabled: true,
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                      compassEnabled: true,
                    ),
              container(),
              // Drawer
              menuButton(context),
            ]),
          ),
        ));
  }

  Future<String> getAddress(double? lat, double? lang) async {
    return geocoding.placemarkFromCoordinates(lat!, lang!).then((placemarks) {
      geocoding.Placemark place = placemarks[0];

      setState(() {
        currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        currentLocationInput.text =
            "${place.name}, ${place.locality}, ${place.postalCode}";

        print(currentAddress);
      });

      return "${place.name},${place.subAdministrativeArea}, ${place.locality}";
    });
  }

  getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        print("Home");
        print(location);
        setState(() {
          currentLocation = location;
          sourceLocation = location;
          getAddress(location.latitude, location.longitude);

          getCarsPosition();

          print("Location---Home------" + currentAddress);
          print(currentLocation);
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
                    sourceLocation = newLoc;
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

    setState(() {
      currentLocationInput.text = currentAddress;
    });
  }

  Positioned container({Widget? child}) => Positioned(
      bottom: 10,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            color: OColors.primary,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: const Offset(0.7, 0.7))
            ]),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: searchAddress,
        ),
      ));

  Widget get searchAddress => Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 60,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "From: ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 20,
                          child: TextField(
                            controller: currentLocationInput,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white70),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Search box
                      SizedBox(
                        width: 175,
                        // decoration: BoxDecoration(
                        //   // color: Colors.grey[500]!.withOpacity(0.5),
                        //   // borderRadius: BorderRadius.circular(8),
                        // ),
                        child: Container(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextField(
                              controller: destinationController,
                              decoration: InputDecoration(
                                  hintText: 'Where to?',
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: OColors.white.withOpacity(1)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(.5)),
                                  )),
                              // obscureText: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              onTap: () => showDialog(
                                builder: (BuildContext context) =>
                                    AddressSearchDialog(
                                  geoMethods: geoMethods,
                                  controller: destinationController,
                                  onDone: (Address address) =>
                                      destinationAddress = address,
                                ),
                                context: context,
                              ),
                            )),
                      ),

                      // Search Icon
                      GestureDetector(
                        onTap: () {
                          if (destinationController.text.isNotEmpty &&
                              currentLocationInput.text.isNotEmpty) {
                            Pager(
                                context,
                                Tracking(
                                  from: currentLocationInput.text,
                                  to: destinationController.text,
                                ));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                            color: OColors.buttonColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          // ignore: deprecated_member_use
                          child: const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );

  Widget get vehiclesView => Expanded(
          child: ListView(
        children: [],
      ));

  Widget get amountView => Column();

  Positioned menuButton(BuildContext context) {
    return Positioned(
        top: 25,
        left: 0,
        child: Container(
          child: _menuButton(context),
        ));
  }

  Positioned logo() {
    return Positioned(
        top: 10,
        right: 0,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, right: 15),
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: 50,
            height: 50,
          ),
        ));
  }

  setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/car-mini.png")
        .then(
      (icon) {
        carsIcon = icon;
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
