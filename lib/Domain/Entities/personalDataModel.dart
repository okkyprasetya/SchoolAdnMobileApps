import 'package:equatable/equatable.dart';

class PersonalDataModel extends Equatable {
  PersonalDataModel({
    required this.upDataId,
    required this.ugDataId,
    required this.fatherName,
    required this.fatherAddress,
    required this.fatherJob,
    required this.fatherSalary,
    required this.motherName,
    required this.motherAddress,
    required this.motherJob,
    required this.motherSalary,
    required this.siblingsNumber,
    required this.hobi,
    required this.kkDocument,
    required this.birthDocument,
    required this.isVerified,
  });

  final int upDataId;
  static const String upDataIdKey = "upDataID";

  final int ugDataId;
  static const String ugDataIdKey = "ugDataID";

  final String fatherName;
  static const String fatherNameKey = "fatherName";

  final String fatherAddress;
  static const String fatherAddressKey = "fatherAddress";

  final String fatherJob;
  static const String fatherJobKey = "fatherJob";

  final int fatherSalary;
  static const String fatherSalaryKey = "fatherSalary";

  final String motherName;
  static const String motherNameKey = "motherName";

  final String motherAddress;
  static const String motherAddressKey = "motherAddress";

  final String motherJob;
  static const String motherJobKey = "motherJob";

  final int motherSalary;
  static const String motherSalaryKey = "motherSalary";

  final int siblingsNumber;
  static const String siblingsNumberKey = "siblingsNumber";

  final String hobi;
  static const String hobiKey = "hobi";

  final String kkDocument;
  static const String kkDocumentKey = "kkDocument";

  final String birthDocument;
  static const String birthDocumentKey = "birthDocument";

  final bool isVerified;
  static const String isVerifiedKey = "isVerified";


  factory PersonalDataModel.fromJson(Map<String, dynamic> json){
    return PersonalDataModel(
      upDataId: json["upDataID"] ?? 0,
      ugDataId: json["ugDataID"] ?? 0,
      fatherName: json["fatherName"] ?? "",
      fatherAddress: json["fatherAddress"] ?? "",
      fatherJob: json["fatherJob"] ?? "",
      fatherSalary: json["fatherSalary"] ?? 0,
      motherName: json["motherName"] ?? "",
      motherAddress: json["motherAddress"] ?? "",
      motherJob: json["motherJob"] ?? "",
      motherSalary: json["motherSalary"] ?? 0,
      siblingsNumber: json["siblingsNumber"] ?? 0,
      hobi: json["hobi"] ?? "",
      kkDocument: json["kkDocument"] ?? "",
      birthDocument: json["birthDocument"] ?? "",
      isVerified: json["isVerified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "upDataID": upDataId,
    "ugDataID": ugDataId,
    "fatherName": fatherName,
    "fatherAddress": fatherAddress,
    "fatherJob": fatherJob,
    "fatherSalary": fatherSalary,
    "motherName": motherName,
    "motherAddress": motherAddress,
    "motherJob": motherJob,
    "motherSalary": motherSalary,
    "siblingsNumber": siblingsNumber,
    "hobi": hobi,
    "kkDocument": kkDocument,
    "birthDocument": birthDocument,
    "isVerified": isVerified,
  };

  @override
  String toString(){
    return "$upDataId, $ugDataId, $fatherName, $fatherAddress, $fatherJob, $fatherSalary, $motherName, $motherAddress, $motherJob, $motherSalary, $siblingsNumber, $hobi, $kkDocument, $birthDocument, $isVerified, ";
  }

  @override
  List<Object?> get props => [
    upDataId, ugDataId, fatherName, fatherAddress, fatherJob, fatherSalary, motherName, motherAddress, motherJob, motherSalary, siblingsNumber, hobi, kkDocument, birthDocument, isVerified, ];

}