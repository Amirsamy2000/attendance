import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'HRAcount.dart';
import 'LoginModel.dart';
import 'attenance.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home :MyApp()));
}

class MyApp extends StatelessWidget {
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
                children: [
                  _buildButton(context, 'ATTENDANCE', Icons.calendar_today, Colors.blue, 0),
                  SizedBox(height: 16),
                  _buildButton(context, 'HR ACCOUNT', Icons.access_time, Colors.green, 1),
                  SizedBox(height: 16),
                  _buildButton(context, 'VACATIONS', Icons.beach_access, Colors.orange, 2),
                ],
              ),
            ),
          ],
        ),
      );
  }

  // Widget _buildButton(BuildContext context, String label, IconData iconData, Color iconColor, int na) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.8,
  //     height: 100,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 3,
  //           blurRadius: 5,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: ElevatedButton.icon(
  //       onPressed: () {
  //
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => attenance()),
  //         );
  //       },
  //       icon: Icon(
  //         iconData,
  //         color: iconColor,
  //       ),
  //       label: Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         primary: Colors.transparent,
  //         shadowColor: Colors.transparent,
  //       ),
  //     ),
  //   );
  // }
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
          if (label == 'ATTENDANCE') {
            checkLocationPermission();
            testAtt(context,158);
            // Navigate to the attenance screen
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => attenance()),
            // );


          } else if (label == 'HR ACCOUNT') {
            // Handle HR ACCOUNT button action if needed

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HRAccount()),
            );
          } else if (label == 'VACATIONS') {
            // Handle VACATIONS button action if needed
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


  Future<void> checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      // Location permission is already granted
      print('Location permission granted');
    } else {
      // Location permission is not granted, request it
      final result = await Permission.location.request();
      if (result == PermissionStatus.granted) {
        // User granted location permission
        print('Location permission granted');
      } else {
        // User denied location permission
        print('Location permission denied');
      }
    }
  }

  // Future<void> getAttendanceState(int id) async {
  //   final String baseUrl = "https://attendance-api.tbico.cloud/";
  //   final String endpoint = "api/Employee/GetAttendanceState";
  //
  //   try {
  //     final Uri uri = Uri.parse('$baseUrl$endpoint');
  //
  //     // Convert the LocationModelApi object to a map
  //     final Map<String, dynamic> locationMap = id as Map<String, dynamic>;
  //
  //     final response = await http.post(
  //       uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       // Convert the location data to JSON and include it in the request body
  //       body: jsonEncode(id),
  //     );
  //
  //     if (response.statusCode == 1) {
  //       // If the server returns a 200 OK response, parse the JSON
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       // task taskvar = task();
  //       // taskvar.message;
  //       print('Attendance State1: $data');
  //     }
  //     else if (response.statusCode ==2){
  //       // If the server returns a 200 OK response, parse the JSON
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       // task taskvar = task();
  //       // taskvar.message;
  //       print('Attendance State2: $data');
  //     }
  //     else {
  //       // If the server did not return a 200 OK response,
  //       // throw an exception.
  //       print('Failed to get attendance state. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }


  Future<LoginModel> testAtt(BuildContext context,int employeeId) async {
    final String baseUrl = "https://attendance-api.tbico.cloud/";
    final String endpoint = "api/Employee/GetAttendanceState";

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint?EmployeeId=$employeeId');
      final response = await http.get(uri, headers: {
        // Add any headers if needed
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        print('Attendance State: $data');
        if(data['State']==1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => attenance()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => attenance()),
          );
        }
        return LoginModel.fromJson(data);
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to get attendance state. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error: $error');
      throw error;
    }
  }


}


