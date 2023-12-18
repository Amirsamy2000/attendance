import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'attenance.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const attenance()),
          );
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
}


