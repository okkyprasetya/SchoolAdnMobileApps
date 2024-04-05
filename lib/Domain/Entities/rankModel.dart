import 'package:equatable/equatable.dart';

class RankModel extends Equatable {
  RankModel({
    required this.rank,
    required this.registrationId,
    required this.name,
    required this.totalScore,
    required this.status,
  });

  final int rank;
  static const String rankKey = "rank";

  final int registrationId;
  static const String registrationIdKey = "registrationID";

  final String name;
  static const String nameKey = "name";

  final int totalScore;
  static const String totalScoreKey = "totalScore";

  final String status;
  static const String statusKey = "status";


  factory RankModel.fromJson(Map<String, dynamic> json){
    return RankModel(
      rank: json["rank"] ?? 0,
      registrationId: json["registrationID"] ?? 0,
      name: json["name"] ?? "",
      totalScore: json["totalScore"] ?? 0,
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "registrationID": registrationId,
    "name": name,
    "totalScore": totalScore,
    "status": status,
  };

  @override
  String toString(){
    return "$rank, $registrationId, $name, $totalScore, $status, ";
  }

  @override
  List<Object?> get props => [
    rank, registrationId, name, totalScore, status, ];

}

/*
{
	"rank": 1,
	"registrationID": 47,
	"name": "User Test Create",
	"totalScore": 246,
	"status": "Accepted"
}*/