import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class attenance extends StatefulWidget {
  @override
  _attenanceState createState() => _attenanceState();
}

class _attenanceState extends State<attenance> {
  double? latitude;
  double? longitude;
  var ColIcon = Colors.white;
  String text = "";
  bool isIconChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                isIconChanged
                    ? Icon(
                  Icons.check_circle,
                  size: 50,
                  color: ColIcon,
                )
                    : Icon(
                  Icons.error,
                  size: 50,
                  color: ColIcon,
                ),
                Text(text),
                SizedBox(height: 50),
                _buildButton(
                  context,
                  'Attend',
                  Icons.logout,
                  Colors.orange,
                  0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String label,
      IconData iconData,
      Color iconColor,
      int na,
      ) {
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
          if (label == 'Attend') {
            getLocation();
            getCurrentLocation();
            // LocationModelApi locationData = LocationModelApi(longitude!, latitude!,  158);
            // getAttendanceState(locationData);
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
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      LocationModelApi locationData =
      LocationModelApi(position.longitude!,position.latitude, 158);
      var c = getAttendanceState(locationData);
      print("==================================================");
      print("==================================================");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle the case where the user denied access to location
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Access to location granted, now you can get the location
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      print(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    }
  }

  Future<void> getAttendanceState(LocationModelApi locationData) async {
    final String baseUrl = "https://attendance-api.tbico.cloud/";
    final String endpoint = "api/Employee/EmployeeAttendanceV2";

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');

      // Convert the LocationModelApi object to a map
      final Map<String, dynamic> locationMap = locationData.toMap();

      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // Convert the location data to JSON and include it in the request body
        body: jsonEncode(locationMap),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        // task taskvar = task();
        // taskvar.message;
        print('Attendance State: $data');

        // Update the UI based on the response
        setState(() {

          text=data['message'];
          if(data['State']==200){
            ColIcon=Colors.green;
            isIconChanged = true;
          }
          else{
            isIconChanged = false;
            ColIcon=Colors.red;

          }


        });
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print(
            'Failed to get attendance state. Status code: ${response.statusCode}');
        // Update the UI based on the response
        setState(() {
          isIconChanged = false;
        });
      }
    } catch (error) {
      // Handle any errors
      print('Error: $error');
      // Update the UI based on the response
      setState(() {
        isIconChanged = false;
      });
    }
  }
}

class LocationModelApi {
  double longitude;
  double latitude;
  int id;

  LocationModelApi(this.longitude, this.latitude, this.id);

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'id': id,
    };
  }
}
