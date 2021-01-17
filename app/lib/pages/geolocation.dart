import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  var location = new Location();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  Map<String, double> currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            currentLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    currentLocation["latitude"].toString() +
                    " " +
                    currentLocation["longitude"].toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      currentLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
      /* 
        ["latitude"];
        ["longitude"];
        ["accuracy"];
        ["altitude"];
        ["speed"];
        ["speed_accuracy"]; //Not for iOS
      */
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  _getMacroLocation(){
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddress();
    }).catchError((e) {
      print(e);
    });
  }


  _getAddress() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    Placemark currentPlace = p[0];
    setState(() {
      _currentAddress =
          "${currentPlace.locality}, ${currentPlace.postalCode}, ${currentPlace.country}";
    });
  } catch (e) {
    print(e);
  }
  
}


