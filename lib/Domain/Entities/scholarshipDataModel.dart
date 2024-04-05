import 'package:equatable/equatable.dart';

class ScholarshipDataModel extends Equatable {
  ScholarshipDataModel({
    required this.scholarshipId,
    required this.name,
    required this.provider,
    required this.benefit,
  });

  final int scholarshipId;
  static const String scholarshipIdKey = "scholarshipID";

  final String name;
  static const String nameKey = "name";

  final String provider;
  static const String providerKey = "provider";

  final String benefit;
  static const String benefitKey = "benefit";


  factory ScholarshipDataModel.fromJson(Map<String, dynamic> json){
    return ScholarshipDataModel(
      scholarshipId: json["scholarshipID"] ?? 0,
      name: json["name"] ?? "",
      provider: json["provider"] ?? "",
      benefit: json["benefit"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "scholarshipID": scholarshipId,
    "name": name,
    "provider": provider,
    "benefit": benefit,
  };

  @override
  String toString(){
    return "$scholarshipId, $name, $provider, $benefit, ";
  }

  @override
  List<Object?> get props => [
    scholarshipId, name, provider, benefit, ];

}

