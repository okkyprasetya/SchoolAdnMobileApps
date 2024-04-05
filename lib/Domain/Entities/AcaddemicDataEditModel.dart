import 'package:equatable/equatable.dart';

class AcademicDataEditModel extends Equatable {
  AcademicDataEditModel({
    required this.uagDataId,
    required this.uaDataId,
    required this.raportSUmmaries,
    required this.raportDocument,
  });

  final int uagDataId;
  static const String uagDataIdKey = "uagDataID";

  final int uaDataId;
  static const String uaDataIdKey = "uaDataID";

  final int raportSUmmaries;
  static const String raportSUmmariesKey = "raportSUmmaries";

  final String raportDocument;
  static const String raportDocumentKey = "raportDocument";


  factory AcademicDataEditModel.fromJson(Map<String, dynamic> json){
    return AcademicDataEditModel(
      uagDataId: json["uagDataID"] ?? 0,
      uaDataId: json["uaDataID"] ?? 0,
      raportSUmmaries: json["raportSUmmaries"] ?? 0,
      raportDocument: json["raportDocument"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "uagDataID": uagDataId,
    "uaDataID" : uaDataId,
    "raportSUmmaries": raportSUmmaries,
    "raportDocument": raportDocument,
  };

  @override
  String toString(){
    return "$uagDataId, $uaDataId, $raportSUmmaries, $raportDocument, ";
  }

  @override
  List<Object?> get props => [
    uagDataId, uaDataId,raportSUmmaries, raportDocument, ];

}

/*
{
	"uagDataID": 52,
	"raportSUmmaries": 0,
	"raportDocument": ""
}*/