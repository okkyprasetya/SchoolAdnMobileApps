import 'package:equatable/equatable.dart';

class AcademicDataModel extends Equatable {
  AcademicDataModel({
    required this.uaDataId,
    required this.uagDataId,
    required this.raportSUmmaries,
    required this.raportDocument,
    required this.isVerified,
  });

  final int uaDataId;
  static const String uaDataIdKey = "uaDataID";

  final int uagDataId;
  static const String uagDataIdKey = "uagDataID";

  final int raportSUmmaries;
  static const String raportSUmmariesKey = "raportSUmmaries";

  final String raportDocument;
  static const String raportDocumentKey = "raportDocument";

  final bool isVerified;
  static const String isVerifiedKey = "isVerified";


  factory AcademicDataModel.fromJson(Map<String, dynamic> json){
    return AcademicDataModel(
      uaDataId: json["uaDataID"] ?? 0,
      uagDataId: json["uagDataID"] ?? 0,
      raportSUmmaries: json["raportSUmmaries"] ?? 0,
      raportDocument: json["raportDocument"] ?? "",
      isVerified: json["isVerified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "uaDataID": uaDataId,
    "uagDataID": uagDataId,
    "raportSUmmaries": raportSUmmaries,
    "raportDocument": raportDocument,
    "isVerified": isVerified,
  };

  @override
  String toString(){
    return "$uaDataId, $uagDataId, $raportSUmmaries, $raportDocument, $isVerified, ";
  }

  @override
  List<Object?> get props => [
    uaDataId, uagDataId, raportSUmmaries, raportDocument, isVerified, ];

}
