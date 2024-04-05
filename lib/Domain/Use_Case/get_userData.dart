
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';

Future<ApplicantModel> getUserData(String token, String email) async {
  Map<String, dynamic> userDetails = await UserRepository().fetchUserDetails(email);
  ApplicantModel applicant = new ApplicantModel(
      userId: userDetails['userID'],
      password: "",
      userEmail: userDetails['userEmail'],
      firstName: userDetails['firstName'],
      middleName: userDetails['middleName'],
      lastName: userDetails['lastName'],
      roleId: userDetails['roleID']
  );
  return applicant;
}