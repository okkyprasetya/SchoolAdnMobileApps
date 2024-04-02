import 'package:equatable/equatable.dart';

class GeneralDataModel extends Equatable {
  GeneralDataModel({
    required this.ugDataId,
    required this.nis,
    required this.dateBirth,
    required this.isScholarship,
    required this.scholarshipId,
    required this.countVerif,
    required this.isFinal,
  });

  final int ugDataId;
  final dynamic nis;
  final dynamic dateBirth;
  final bool isScholarship;
  final int scholarshipId;
  final int countVerif;
  final bool isFinal;

  factory GeneralDataModel.fromJson(Map<String, dynamic> json){
    return GeneralDataModel(
      ugDataId: json["ugDataID"] == 0 ? 0 : json["ugDataID"],
      nis: json["nis"] == null ? "Not set yet" : json["nis"],
      dateBirth: json["dateBirth"] == null ? "Not set yet": json["dateBirth"],
      isScholarship: json["isScholarship"] == null ? false: json["isScholarship"],
      scholarshipId: json["scholarshipID"] == null ? 0 : json["scholarshipID"],
      countVerif: json["countVerif"] == null ? 0: json["countVerif"],
      isFinal: json["isFinal"] == null? false: json["isFinal"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ugDataID": ugDataId,
    "nis": nis,
    "dateBirth": dateBirth,
    "isScholarship": isScholarship,
    "scholarshipID": scholarshipId,
    "countVerif": countVerif,
    "isFinal": isFinal,
  };

  @override
  String toString(){
    return "$ugDataId, $nis, $dateBirth, $isScholarship, $scholarshipId, $countVerif, $isFinal, ";
  }

  @override
  List<Object?> get props => [
    ugDataId, nis, dateBirth, isScholarship, scholarshipId, countVerif, isFinal, ];
}
