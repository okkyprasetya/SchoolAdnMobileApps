import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';

class UserRepository{
  Future<String> login(Map<String, dynamic> user) async {
    String token = await ProductionSource().login(user);
    return token;
  }

  Future<Map<String, dynamic>> fetchUserDetails(String email) async {
    try {
      final userDetails = await ProductionSource().fetchUserDetails(email);
      return userDetails;
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<Map<String, dynamic>> fetchGeneralData(String email,String token) async{
    try{
      final generalData = await ProductionSource().fetchGeneralData(email, token);
      return generalData;
    }
    catch(e){
      throw Exception('Failed to fetch the data: $e');
    }
  }
}