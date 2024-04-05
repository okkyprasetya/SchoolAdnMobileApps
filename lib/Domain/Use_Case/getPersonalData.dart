import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/academicData.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataModel.dart';

Future<PersonalDataModel> getPersonalData(String token, String email) async {
  Map<String, dynamic> personalData = await UserRepository().fetchPersonalData(email, token);
   PersonalDataModel applicantPersonalData = new PersonalDataModel(
       ugDataId: personalData['ugDataID'],
       upDataId: personalData['upDataID'],
       fatherName: personalData['fatherName'],
       fatherAddress: personalData['fatherAddress'],
       fatherJob: personalData['fatherJob'],
       fatherSalary: personalData['fatherSalary'],
       motherName: personalData['motherName'],
       motherAddress: personalData['motherAddress'],
       motherJob: personalData['motherJob'],
       motherSalary: personalData['motherSalary'],
       siblingsNumber: personalData['siblingsNumber'],
       hobi: personalData['hobi'],
       kkDocument: personalData['kkDocument'],
       birthDocument: personalData['birthDocument'],
       isVerified: personalData['isVerified']
  );
  return applicantPersonalData;
}