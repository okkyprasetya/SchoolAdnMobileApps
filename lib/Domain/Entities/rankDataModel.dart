import 'package:equatable/equatable.dart';

class RankDataModel extends Equatable {
  RankDataModel({
    required this.rank,
    required this.registrationId,
    required this.name,
    required this.totalScore,
    required this.status,
    required this.users,
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

  final dynamic users;
  static const String usersKey = "users";


  factory RankDataModel.fromJson(Map<String, dynamic> json){
    return RankDataModel(
      rank: json["rank"] ?? 0,
      registrationId: json["registrationID"] ?? 0,
      name: json["name"] ?? "",
      totalScore: json["totalScore"] ?? 0,
      status: json["status"] ?? "",
      users: json["users"],
    );
  }

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "registrationID": registrationId,
    "name": name,
    "totalScore": totalScore,
    "status": status,
    "users": users,
  };

  @override
  String toString(){
    return "$rank, $registrationId, $name, $totalScore, $status, $users, ";
  }

  @override
  List<Object?> get props => [
    rank, registrationId, name, totalScore, status, users, ];

}

