import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/academicData.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/rankDataModel.dart';
import 'package:schooladn_rev/Domain/Use_Case/getAcademicData.dart';
import 'package:schooladn_rev/Domain/Use_Case/getPersonalData.dart';
import 'package:schooladn_rev/Domain/Use_Case/get_applicantGData.dart';
import 'package:schooladn_rev/Presentation/academicdata_page.dart';
import 'package:schooladn_rev/Presentation/generaldata_page.dart';
import 'package:schooladn_rev/Presentation/leaderboard_page.dart';
import 'package:schooladn_rev/Presentation/personaldata_page.dart';

class ProfilePage extends StatelessWidget {
  final String token;
  final ApplicantModel applicant;

  const ProfilePage({Key? key, required this.token, required this.applicant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  color: Colors.white,
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                            'User ID', applicant.userId.toString()),
                        _buildDetailRow('Email', applicant.userEmail),
                        _buildDetailRow(
                            'Name',
                            '${applicant.firstName} ${applicant.middleName} ${applicant.lastName}'),
                        _buildDetailRow('Role',
                            applicant.roleId.toString() == '2' ? "Applicant" : "Non-Applicant"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildCardWithTitle(
                  'General Data',
                      () async {
                    String email = applicant.userEmail;
                    if (token != null) {
                      GeneralDataModel generalData =
                      await getApplicantGeneralData(token, email);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeneralDataCard(
                            gdata: generalData,
                            token: token,
                          ),
                        ),
                      );
                    }
                  },
                ),
                _buildCardWithTitle(
                  'Academic Data',
                      () async {
                    String email = applicant.userEmail;
                    if (token != null) {
                      AcademicDataModel academicData =
                      await getAcademicData(token, email);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcademicDataCard(
                            academicData: academicData,
                            token: token,
                          ),
                        ),
                      );
                    }
                  },
                ),
                _buildCardWithTitle(
                  'Personal Data',
                      () async {
                    String email = applicant.userEmail;
                    if (token != null) {
                      PersonalDataModel personalData =
                      await getPersonalData(token, email);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalDataPage(
                            personalData: personalData,
                            token: token,
                          ),
                        ),
                      );
                    }
                  },
                ),
                _buildCardWithTitle('Achievement Records', () {}),
                _buildCardWithTitle(
                  'View Leaderboard',
                      () async {
                    if (token != null) {
                      List<RankDataModel> rankData =
                      await UserRepository().getRank(token);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaderboardPage(token: token),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    elevation: 8,
                  ),
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithTitle(String title, Function() onTap) {
    return Card(
      elevation: 8,
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
