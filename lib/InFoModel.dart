class InFoModel {
  int state;
  ProfileModel empInfo;

  InFoModel({required this.state, required this.empInfo});

  factory InFoModel.fromJson(Map<String, dynamic> json) {
    return InFoModel(
      state: json['State'] as int,
      empInfo: ProfileModel.fromJson(json['Emp_Info'] as Map<String, dynamic>),
    );
  }
}

class ProfileModel {
  String empId;
  String enEmpName;
  String aEmpName;
  String dateOfHiring;
  String endOfHiring;
  String employeeInsurance;
  int countViolations;
  int countDeductions;
  int countAbsent;
  double employeeSalary;
  int employeeCompany;

  ProfileModel({
    required this.empId,
    required this.enEmpName,
    required this.aEmpName,
    required this.dateOfHiring,
    required this.endOfHiring,
    required this.employeeInsurance,
    required this.countViolations,
    required this.countDeductions,
    required this.countAbsent,
    required this.employeeSalary,
    required this.employeeCompany,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      empId: json['EmpId'].toString(),
      enEmpName: json['EnEmpName'] as String,
      aEmpName: json['AEmpName'] as String,
      dateOfHiring: json['DateOfHiring'] as String,
      endOfHiring: json['EndOfHiring'] as String,
      employeeInsurance: json['EmployeeInsrance'] as String,
      countViolations: json['Countviolations'] as int,
      countDeductions: json['CountDeductions'] as int,
      countAbsent: json['CountAbsent'] as int,
      employeeSalary: json['EmployeeSalary'] as double,
      employeeCompany: json['EmployeeCompany'] as int,
    );
  }
}
