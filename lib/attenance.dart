import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class attenance extends StatelessWidget {
  double? latitude;
  double? longitude;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/att.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height:50),
                _buildButton(context, 'SUBMIT', Icons.beach_access, Colors.orange, 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildButton(BuildContext context, String label, IconData iconData, Color iconColor, int na) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          // Check the label to determine which action to perform
          print('Button pressed: $label');
          if (label == 'SUBMIT') {
            getLocation();
            getCurrentLocation();
          }
        },
        icon: Icon(
          iconData,
          color: iconColor,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
    );
  }
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
     // print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle the case where the user denied access to location
    } else if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Access to location granted, now you can get the location
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    }
  }

}