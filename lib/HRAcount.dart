import 'package:flutter/material.dart';

class HRAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('HR Account'),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                'Personal Info',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildInfoRow('Name', 'Mohamed '),
              _buildInfoRow('ID', '30'),
              _buildInfoRow('Absent count', '16'),
              _buildInfoRow('count of voilation', '123 Main St, City'),
              _buildInfoRow('phone', '01012900509'),
              SizedBox(height: 32),
              Text(
                'Company Info',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildInfoRow('Company Name', ' TBI'),
              _buildInfoRow('branch', 'HO'),
              _buildInfoRow('employee year exp', 'Jan 1, 2024'),
              _buildInfoRow('Employee hire date', 'Jan 1, 2023'),
              _buildInfoRow('salary', '22000 '),
            ],
          ),
        ),
      ),
    );
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
}


