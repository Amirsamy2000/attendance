import 'package:attendance/HRAcount.dart';
import 'package:attendance/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:flutter/services.dart';
//import 'package:get_mac_address/get_mac_address.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

String Wat="Weating";
String macAddress = 'Loading...';
bool active=true;
// final _getMacAddressPlugin = GetMacAddress();
  @override
  void initState() {
    super.initState();
    //initPlatformState("Adddkmdsfsdf102dsf");
    GetSateEmployee(macAddress,context);
  }
  Future<void> GetSateEmployee(String androidId,BuildContext context) async {
    final String baseUrl = "https://attendance-api.tbico.cloud/";
    final String endpoint = "api/Employee/Employee_Login";
    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');

      // Create a Map to represent the request body
      final Map<String, dynamic> requestBody = {
        'androidId': androidId,
        // Add other fields if needed
      };

      // Convert the request body to JSON
      final String requestBodyJson = jsonEncode(requestBody);

      // Make the POST request
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Add other headers if needed
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("--------------------------------------------------------------------------");
        print('Response Data: $responseData');
        print('Response Data: ${responseData['State']}');
        if(responseData['State']==202){
          // Move to  Page To Create Resquest
          print("fppppp");

          Navigator.push(context, MaterialPageRoute(builder: (context) => HRAccount()));

        }
        else if(responseData['State']==201){

          setState((){
            active=false;
            Wat=responseData['State'];
          });

        }
        else if(responseData['State']==200){
          setState((){
          MaterialPageRoute(builder: (context) => MyApp());
          });
        }
        else{
          setState((){
            active=false;
            Wat="Erro In Login Try Agin";
          });
        }

      } else {
        // Request failed, handle the error
        print('Failed to make POST request. Status code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions that may occur
      print('Error: $error');
    }
  }
Future<void> initPlatformState(String s) async {
  //String macAddress;
  // Platform messages may fail, so we use a try/catch PlatformException.
  // We also handle the message potentially returning null.
  try {
  //  macAddress = await _getMacAddressPlugin.getMacAddress() ?? 'Unknown mac address';
  } on PlatformException {
    macAddress = 'Failed to get mac address.';
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  if (!mounted) return;

  setState(() {
 //   macAddress = macAddress;
  });
}
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/Login.jpg', // Replace with your image path
              width: 400.0, // Adjust the width as needed
              height: 400.0, // Adjust the height as needed
            ),
            active==true?CircularProgressIndicator():Text(""),
            SizedBox(height: 16.0), // Add spacing between image and text
            Text(
              Wat,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  }


  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }


