import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition;
  double distanceInMeter = 0;

  Future _getTheDistance() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double currentLat = _currentPosition!.latitude;
    double currentLon = _currentPosition!.longitude;

    // print('current lat  : ${currentLat} , long : $currentLon');

    distanceInMeter = await Geolocator.distanceBetween(
        8.5241, 76.9366, currentLat, currentLon);

    print('distance : $distanceInMeter');
    return distanceInMeter;
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Current latitude : ${_currentPosition!.latitude.toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              'Current longitude : ${_currentPosition!.longitude.toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              'Total Distance from Trivandrum to your current position :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              ' ${(distanceInMeter / 1000).toStringAsFixed(2)} kms',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _getTheDistance();
                  });
                },
                child: const Text('Click here'))
          ],
        ),
      ),
    );
  }
}
