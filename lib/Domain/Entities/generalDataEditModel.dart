import 'package:equatable/equatable.dart';

class GeneralDataEditModel extends Equatable {
  GeneralDataEditModel({
    required this.ugDataId,
    required this.nis,
    required this.dateBirth,
    required this.isScholarship,
    required this.scholarshipId,
  });

  final int ugDataId;
  static const String ugDataIdKey = "ugDataID";

  final String nis;
  static const String nisKey = "nis";

  final String dateBirth;
  static const String dateBirthKey = "dateBirth";

  final bool isScholarship;
  static const String isScholarshipKey = "isScholarship";

  final int scholarshipId;
  static const String scholarshipIdKey = "scholarshipID";


  factory GeneralDataEditModel.fromJson(Map<String, dynamic> json){
    return GeneralDataEditModel(
      ugDataId: json["ugDataID"] ?? 0,
      nis: json["nis"] ?? "",
      dateBirth: json["dateBirth"] ?? "",
      isScholarship: json["isScholarship"] ?? false,
      scholarshipId: json["scholarshipID"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "ugDataID": ugDataId,
    "nis": nis,
    "dateBirth": dateBirth,
    "isScholarship": isScholarship,
    "scholarshipID": scholarshipId,
  };

  @override
  String toString(){
    return "$ugDataId, $nis, $dateBirth, $isScholarship, $scholarshipId, ";
  }

  @override
  List<Object?> get props => [
    ugDataId, nis, dateBirth, isScholarship, scholarshipId, ];

}

/*
{
	"ugDataID": 0,
	"nis": "string",
	"dateBirth": "string",
	"isScholarship": true,
	"scholarshipID": 0
}*/