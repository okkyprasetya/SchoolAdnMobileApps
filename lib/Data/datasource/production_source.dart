import 'dart:convert';

import 'package:schooladn_rev/Data/datasource/source.dart';
import 'package:http/http.dart' as http;
import 'package:schooladn_rev/Domain/Entities/AcaddemicDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/rankDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/scholarshipDataModel.dart';

class ProductionSource extends Source {
  static const url = "https://localhost:7061/api/Applicant";

  @override
  Future<String> login(Map<String, dynamic> user) async {
    try {
      var response = await http.post(
        Uri.parse('$url/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': user['email'],
          'password': user['password']
        }),
      );

      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object containing the token
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];
        return token;
      } else if (response.statusCode == 400) {
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }


  Future<Map<String, dynamic>> fetchUserDetails(String email) async {
    try {
      var response = await http.get(
        Uri.parse('$url?email=${email}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object containing the token
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 400) {
        throw Exception('Failed to fetch the data');
      } else {
        throw Exception('Failed to fetch the data');
      }
    } catch (e) {
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchGeneralData(String email,
      String token) async {
    try {
      var response = await http.get(
          Uri.parse('$url/getApplicantData?email=${email}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${token}'
          }
      );
      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object containing the token
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 400) {
        throw Exception('Failed to fetch the data');
      } else {
        throw Exception('Failed to fetch the data');
      }
    } catch (e) {
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchAcademicData(String email,
      String token) async {
    try {
      var response = await http.get(
          Uri.parse('$url/getAcademicData?email=${email}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${token}'
          }
      );
      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object containing the token
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 400) {
        throw Exception('Failed to fetch the data');
      } else {
        throw Exception('Failed to fetch the data');
      }
    } catch (e) {
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<List<ScholarshipDataModel>> fetchScholarshipName(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$url/getScholarshipData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List;

        return responseData.map((dynamic json){
          final map = json as Map<String,dynamic>;
          return ScholarshipDataModel(
              scholarshipId: map['scholarshipID'] as int,
              name: map['name'] as String,
              provider: map['provider'] as String,
              benefit: map['benefit'] as String
          );
        }).toList();
      } else {
        // If the request was not successful, throw an error
        throw Exception(
            'Failed to fetch scholarship names: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch scholarship names: $e');
    }
  }

  Future<void> editGeneralData(int ugdataId, String token, GeneralDataEditModel newDat) async {
    try {
      var response = await http.post(
        Uri.parse('$url/completeApplicantGeneralData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ugDataID': newDat.ugDataId,
          'nis' : newDat.nis,
          'dateBirth' : newDat.dateBirth,
          'isScholarship': newDat.isScholarship,
          'scholarshipID'  : newDat.scholarshipId
        }),
      );
      if (response.statusCode == 200) {
        // Data edited successfully
        print('General data edited successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Failed to edit general data');
      } else {
        throw Exception('Failed to edit general data');
      }
    } catch (e) {
      throw Exception('Failed to edit general data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchPersonalData(String email,
      String token) async {
    try {
      var response = await http.get(
          Uri.parse('$url/getPersonalData?email=${email}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${token}'
          }
      );
      if (response.statusCode == 200) {
        // Assuming your API returns a JSON object containing the token
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else if (response.statusCode == 400) {
        throw Exception('Failed to fetch the data');
      } else {
        throw Exception('Failed to fetch the data');
      }
    } catch (e) {
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<void> completeAcademicData(int ugdataId, String token, AcademicDataEditModel newDat) async {
    try {
      var response = await http.post(
        Uri.parse('$url/completeApplicantAcademicData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ugDataID': newDat.uagDataId,
          'raportSummaries' : newDat.raportSUmmaries,
          'raportDocument' : newDat.raportDocument,
        }),
      );
      if (response.statusCode == 200) {
        // Data edited successfully
        print('General data edited successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Failed to edit general data');
      } else {
        throw Exception('Failed to edit general data');
      }
    } catch (e) {
      throw Exception('Failed to edit general data: $e');
    }
  }

  Future<void> updateAcademicData(int ugdataId, String token, AcademicDataEditModel newDat) async {
    try {
      var response = await http.put(
        Uri.parse('$url/updateApplicantAcademicData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ugDataID': newDat.uagDataId,
          'uaDataID' : newDat.uaDataId,
          'raportSummaries' : newDat.raportSUmmaries,
          'raportDocument' : newDat.raportDocument,
        }),
      );
      if (response.statusCode == 200) {
        // Data edited successfully
        print('General data edited successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Failed to edit general data');
      } else {
        throw Exception('Failed to edit general data');
      }
    } catch (e) {
      throw Exception('Failed to edit general data: $e');
    }
  }

  Future<void> completePersonalData(int ugdataId, String token, PersonalDataModel newDat) async {
    try {
      var response = await http.post(
        Uri.parse('$url/completeApplicantPersonalData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ugDataID': newDat.ugDataId,
          'fatherName' : newDat.fatherName,
          'fatherAddress' : newDat.fatherAddress,
          'fatherJob' : newDat.fatherJob,
          'fatherSalary' : newDat.fatherSalary,
          'motherName' : newDat.motherName,
          'motherAddress' : newDat.motherAddress,
          'motherJob' : newDat.motherJob,
          'motherSalary' : newDat.motherSalary,
          'siblingsNumber' : newDat.siblingsNumber,
          'hobi' : newDat.hobi,
          'kkDocument' : newDat.kkDocument,
          'birthDocument' : newDat.birthDocument,
        }),
      );
      if (response.statusCode == 200) {
        // Data edited successfully
        print('Personal data edited successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Failed to edit general data');
      } else {
        throw Exception('Failed to edit general data');
      }
    } catch (e) {
      throw Exception('Failed to edit general data: $e');
    }
  }

  Future<void> updatePersonalData(int ugdataId, String token, PersonalDataModel newDat) async {
    try {
      var response = await http.put(
        Uri.parse('$url/updateApplicantPersonalData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'upDataID' : newDat.upDataId,
          'ugDataID': newDat.ugDataId,
          'fatherName' : newDat.fatherName,
          'fatherAddress' : newDat.fatherAddress,
          'fatherJob' : newDat.fatherJob,
          'fatherSalary' : newDat.fatherSalary,
          'motherName' : newDat.motherName,
          'motherAddress' : newDat.motherAddress,
          'motherJob' : newDat.motherJob,
          'motherSalary' : newDat.motherSalary,
          'siblingNumber' : newDat.siblingsNumber,
          'hobi' : newDat.hobi,
          'kkDocument' : newDat.kkDocument,
          'birthDocument' : newDat.birthDocument,
        }),
      );
      if (response.statusCode == 200) {
        // Data edited successfully
        print('Personal data edited successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Failed to edit general data');
      } else {
        throw Exception('Failed to edit general data');
      }
    } catch (e) {
      throw Exception('Failed to edit general data: $e');
    }
  }

  Future<List<RankDataModel>> fetchLeaderboard(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$url/getRank'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List;

        return responseData.map((dynamic json){
          final map = json as Map<String,dynamic>;
          return RankDataModel(
              rank: map['rank'] as int,
              registrationId: map['registrationID'],
              name: map['name'],
              totalScore: map['totalScore'],
              status: map['status'],
              users: null,
          );
        }).toList();
      } else {
        // If the request was not successful, throw an error
        throw Exception(
            'Failed to fetch rank data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch rank data: $e');
    }
  }

  Future<void> register(ApplicantModel applicant) async {
    try {
      var response = await http.post(
        Uri.parse('$url'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': applicant.userEmail, // Use applicant's email
          'password': applicant.password,
          'fname' : applicant.firstName,
          'midname' : applicant.middleName,
          'lname': applicant.lastName,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

}
