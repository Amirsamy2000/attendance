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
  String countViolations;
  String countDeductions;
  String countAbsent;
  String employeeSalary;

  ProfileModel({
    this.empId = '',
    this.enEmpName = '',
    this.aEmpName = '',
    this.dateOfHiring = '',
    this.endOfHiring = '',
    this.employeeInsurance = '',
    this.countViolations = '',
    this.countDeductions = '',
    this.countAbsent = '',
    this.employeeSalary = '',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      empId: json['EmpId'] as String,
      enEmpName: json['EnEmpName'] as String,
      aEmpName: json['AEmpName'] as String,
      dateOfHiring: json['DateOfHiring'] as String,
      endOfHiring: json['EndOfHiring'] as String,
      employeeInsurance: json['EmployeeInsrance'] as String,
      countViolations: json['Countviolations'] as String,
      countDeductions: json['CountDeductions'] as String,
      countAbsent: json['CountAbsent'] as String,
      employeeSalary: json['EmployeeSalary'] as String,
    );
  }

  // Method to update properties with data from API
  void updateFromApi(Map<String, dynamic> json) {
    empId = json['EmpId'] as String;
    enEmpName = json['EnEmpName'] as String;
    aEmpName = json['AEmpName'] as String;
    dateOfHiring = json['DateOfHiring'] as String;
    endOfHiring = json['EndOfHiring'] as String;
    employeeInsurance = json['EmployeeInsrance'] as String;
    countViolations = json['Countviolations'] as String;
    countDeductions = json['CountDeductions'] as String;
    countAbsent = json['CountAbsent'] as String;
    employeeSalary = json['EmployeeSalary'] as String;
  }
}
