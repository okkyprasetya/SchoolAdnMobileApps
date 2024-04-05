
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/academicData.dart';

Future<AcademicDataModel> getAcademicData(String token, String email) async {
  Map<String, dynamic> academicData = await UserRepository().fetchAcademicData(email, token);
  AcademicDataModel applicantAcademicData = new AcademicDataModel(
      uaDataId: academicData['uaDataID'],
      uagDataId: academicData['uagDataID'],
      raportSUmmaries: academicData['raportSUmmaries'],
      raportDocument: academicData['raportDocument'],
      isVerified: academicData['isVerified'],
  );
  return applicantAcademicData;
}