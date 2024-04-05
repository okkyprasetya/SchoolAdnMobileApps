
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';

Future<GeneralDataModel> getApplicantGeneralData(String token, String email) async {
  Map<String, dynamic> generalData = await UserRepository().fetchGeneralData(email, token);
  GeneralDataModel applicantGData = new GeneralDataModel(
    ugDataId: generalData['ugDataID'],
    nis: generalData['nis'],
    dateBirth: generalData['dateBirth'],
    isScholarship: generalData['isScholarship'],
    scholarshipId: generalData['scholarshipID']?? 0,
    countVerif: generalData['countVerif'],
    isFinal: generalData['isFinal'],
  );
  return applicantGData;
}