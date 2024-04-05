import 'package:equatable/equatable.dart';

class ApplicantModel extends Equatable {
  ApplicantModel({
    required this.userId,
    required this.password,
    required this.userEmail,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.roleId,
  });

  final String password;
  final int userId;
  final String userEmail;
  final String firstName;
  final String middleName;
  final String lastName;
  final int roleId;

  factory ApplicantModel.fromJson(Map<String, dynamic> json){
    return ApplicantModel(
      userId: json["userID"] ?? 0,
      userEmail: json["userEmail"] ?? "",
      password: json["password"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      roleId: json["roleID"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "userEmail": userEmail,
    "password" : password,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "roleID": roleId,
  };

  @override
  String toString(){
    return "$userId, $userEmail,$password, $firstName, $middleName, $lastName, $roleId, ";
  }

  @override
  List<Object?> get props => [
    userId, userEmail,password, firstName, middleName, lastName, roleId, ];

}

