import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Domain/Entities/AcaddemicDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/academicData.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/rankDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/scholarshipDataModel.dart';

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

  Future<Map<String,dynamic>> fetchPersonalData(String email,String token) async{
    try{
      final personalData = await ProductionSource().fetchPersonalData(email,token);
      return personalData;
    }
      catch(e){
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchAcademicData(String email, String token) async {
    try{
      final academicData = await ProductionSource().fetchAcademicData(email, token);
      return academicData;
    }
    catch(e){
      throw Exception('Failed to fetch the data: $e');
    }
  }

  Future<List<ScholarshipDataModel>> fetchScholarshipName(String token) async {
    try {
      final List<ScholarshipDataModel> scholarshipNames = await ProductionSource().fetchScholarshipName(token);
      return scholarshipNames;
    } catch (e) {
      throw Exception('Failed to fetch scholarship names: $e');
    }
  }

  Future<void> editGeneralData(int ugDataId,String token, GeneralDataEditModel genDat)async {
    try{
      await ProductionSource().editGeneralData(ugDataId, token, genDat);
    }catch(e){
      throw Exception('Failed to update the data: $e');
    }
  }

  Future<void> completeAcademicData(int ugDataId,String token, AcademicDataEditModel acData) async{
      try{
        await ProductionSource().completeAcademicData(ugDataId, token, acData);
      }catch(e){
        throw Exception('Failed to complete academic data: $e');
      }
  }

  Future<void> editAcademicData(int ugDataId, String token, AcademicDataEditModel acData) async{
    try{
      await ProductionSource().updateAcademicData(ugDataId, token, acData);
    }
    catch(e){
      throw Exception('Failed to update academic data: $e');
    }
  }

  Future <List<RankDataModel>> getRank(String token) async{
    try{
      final List<RankDataModel> rankData = await ProductionSource().fetchLeaderboard(token);
      return rankData;
    }catch(e){
      throw Exception('Failed to update academic data: $e');
    }
  }

  Future<void> register(ApplicantModel applicant) async{
    try{
      await ProductionSource().register(applicant);
    }
    catch(e){
      throw Exception('Failed to register: $e');
    }
  }
}