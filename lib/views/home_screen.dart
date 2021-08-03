import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morgen_gold/widgets/custom_drawer.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Image.asset(
            "assets/morgengold_logo.png",
            color: Colors.white,
            scale: 2,
          ),
          centerTitle: true,
        ),
        body: MapView(),
      ),
    );
  }

  // WILLPOPSCOPE POPUP ALERT
  Future<bool> _exitApp() async {
    return await Get.defaultDialog(
      title: "willpop_title".tr,
      titleStyle: TextStyle(color: Colors.grey[800], fontSize: 18),
      middleText: "willpop_message".tr,
      middleTextStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      actions: [
        RaisedButton(
          onPressed: () => exit(0),
          color: Colors.red,
          child: Text(
            "willpop_button_exit".tr,
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        RaisedButton(
          onPressed: () => Get.back(),
          color: Colors.grey,
          child: Text(
            "willpop_button_cancel".tr,
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
      radius: 7,
      barrierDismissible: true,
    );
  }
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(21.0, 21.0));
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;
  String _currentAddress;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  String _startAddress = '';
  String _destinationAddress = '';

  final focusNode = FocusNode();

  Set<Marker> markers = {};


  Widget _textField({
    TextEditingController controller,
    String label,
    String hint,
    String initialValue,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        // initialValue: initialValue,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  Future _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  Future _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Placemark> startPlacemark =
      await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
      await _geolocator.placemarkFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        // Use the retrieved coordinates of the current position,
        // instead of the address if the start position is user's
        // current position, as it results in better accuracy.
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
            latitude: _currentPosition.latitude,
            longitude: _currentPosition.longitude)
            : startPlacemark[0].position;
        Position destinationCoordinates = destinationPlacemark[0].position;

        // Start Location Marker
        Marker startMarker = Marker(
          markerId: MarkerId('$startCoordinates'),
          position: LatLng(
            startCoordinates.latitude,
            startCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Start',
            snippet: _startAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
            destinationCoordinates.latitude,
            destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Adding the markers to the list
        markers.add(startMarker);
        markers.add(destinationMarker);
        setState(() {

        });

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        // Calculating to check that the position relative
        // to the frame, and pan & zoom the camera accordingly.
        double miny = (startCoordinates.latitude <= destinationCoordinates.latitude)
            ? startCoordinates.latitude
            : destinationCoordinates.latitude;
        double minx = (startCoordinates.longitude <= destinationCoordinates.longitude)
            ? startCoordinates.longitude
            : destinationCoordinates.longitude;
        double maxy = (startCoordinates.latitude <= destinationCoordinates.latitude)
            ? destinationCoordinates.latitude
            : startCoordinates.latitude;
        double maxx = (startCoordinates.longitude <= destinationCoordinates.longitude)
            ? destinationCoordinates.longitude
            : startCoordinates.longitude;

        _southwestCoordinates = Position(latitude: miny, longitude: minx);
        _northeastCoordinates = Position(latitude: maxy, longitude: maxx);

        // Accommodate the two locations within the
        // camera view of the map
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var deviceH = Get.height;
    var deviceW = Get.width;
    return Container(
      height: deviceH,
      width: deviceW,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              markers: markers != null ? Set<Marker>.from(markers) : null,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.orange, // button color
                        child: InkWell(
                          splashColor: Colors.orange[900], // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add, color: Colors.white,),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.orange, // button color
                        child: InkWell(
                          splashColor: Colors.orange[900], // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove, color: Colors.white,),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange, // button color
                      child: InkWell(
                        splashColor: Colors.orange[900], // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location, color: Colors.white,),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 5, right: 14, left: 14),
                color: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white70,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textField(
                          label: 'Start',
                          hint: 'Choose starting point',
                          initialValue: _currentAddress,
                          prefixIcon: Icon(Icons.looks_one),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.my_location),
                            onPressed: () {
                              startAddressController.text = _currentAddress;
                              _startAddress = _currentAddress;
                            },
                          ),
                          controller: startAddressController,
                          locationCallback: (String value) {
                            setState(() {
                              _startAddress = value;
                            });
                          }),
                      SizedBox(height: 7),
                      _textField(
                          label: 'Destination',
                          hint: 'Choose destination',
                          initialValue: '',
                          prefixIcon: Icon(Icons.looks_two),
                          controller: destinationAddressController,
                          locationCallback: (String value) {
                            setState(() {
                              _destinationAddress = value;
                            });
                          }),
                      SizedBox(
                        height: 7,
                      ),
                      RaisedButton(
                        onPressed: (_startAddress != '' && _destinationAddress != '')
                            ? () async {
                          setState(() {
                            if (markers.isNotEmpty) markers.clear();
                          });

                          _calculateDistance().then((isCalculated) {
                            Get.back();
                            if (isCalculated) {
                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      _currentPosition.latitude,
                                      _currentPosition.longitude,
                                    ),
                                    zoom: 30.0,
                                  ),
                                ),
                              );
                            } else {
                            }
                          });
                        }
                            : null,
                        color: Colors.orange[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
