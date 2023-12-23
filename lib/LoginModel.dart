class LoginModel {
  int state;
  String message;
  String androidId;
  int employeeID;

  // Constructor
  LoginModel({
    required this.state,
    required this.message,
    required this.androidId,
    required this.employeeID,
  });

  // Named constructor for creating an instance from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      state: json['State'] as int,
      message: json['message'] as String,
      androidId: json['AndroidId'] as String,
      employeeID: json['EmployeeID'] as int,
    );
  }
}
