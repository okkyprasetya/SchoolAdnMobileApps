import 'package:schooladn_rev/Data/Repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';

Future<void> register(ApplicantModel applicant) async {
  await UserRepository().register(applicant);
}