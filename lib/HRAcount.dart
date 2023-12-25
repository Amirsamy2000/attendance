import 'dart:ffi';

import 'package:attendance/InFoModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HRAccount extends StatefulWidget {
  @override
  _HRAccountState createState() => _HRAccountState();
}

class _HRAccountState extends State<HRAccount> {
  late Future<InFoModel?> futureInfoModel;

  @override
  void initState() {
    super.initState();
    futureInfoModel = getInfo(158);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Padding(
          padding: const EdgeInsets.all(16.0),

          child:Center(
            child: FutureBuilder<InFoModel?>(

              future: futureInfoModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while waiting for data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.data?.empInfo}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No data available');
                } else {
                  InFoModel infoModel = snapshot.data!;
                  // Display your data using the infoModel
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      _buildInfoRow('Name', '${infoModel.empInfo.enEmpName}'),
                      _buildInfoRow('ID', '${infoModel.empInfo.empId}'),
                      _buildInfoRow('Absent count', '${infoModel.empInfo.countAbsent}'),
                      _buildInfoRow('count of voilation', '${infoModel.empInfo.countViolations}'),

                      SizedBox(height: 32),
                      Text(
                        'Company Info',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow('Company Name', '${infoModel.empInfo.employeeCompany}'),
                      _buildInfoRow('employee year exp', '${infoModel.empInfo.dateOfHiring}'),
                      _buildInfoRow('Employee hire date', '${infoModel.empInfo.endOfHiring}'),
                      _buildInfoRow('salary', '${infoModel.empInfo.employeeSalary} '),
                      // Add more Text widgets for other properties
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
  Future<InFoModel?> getInfo(int x) async {
    final String baseUrl = "https://attendance-api.tbico.cloud/";
    final String endpoint = "api/Employee/GetEmployeeInfo";

    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');

      final int requestBody = x ;

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('HR State: $data');
        return InFoModel.fromJson(data); // Adjust the decoding logic based on your InFoModel class
      } else {
        throw Exception('Failed to get employee info. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
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
}


