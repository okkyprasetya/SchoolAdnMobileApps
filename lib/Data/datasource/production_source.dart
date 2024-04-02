import 'dart:convert';

import 'package:schooladn_rev/Data/datasource/source.dart';
import 'package:http/http.dart' as http;

class ProductionSource extends Source{
  static const url = "https://localhost:7061/api/Applicant";

  @override
  Future<String> login(Map<String, dynamic> user) async{
    try {
      var response = await http.post(
        Uri.parse('$url/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          'email':user['email'],
          'password':user['password']
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
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
  
  Future<Map<String,dynamic>> fetchGeneralData(String email, String token) async{
    try{
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
          throw Exception('Invalid credentials');
        } else {
          throw Exception('Failed to login');
        }
    } catch (e) {
        throw Exception('Failed to login: $e');
    }
  }
}
