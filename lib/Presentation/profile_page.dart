import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';
import 'package:schooladn_rev/Presentation/generaldata_page.dart';
import 'package:schooladn_rev/Provider/token_provider.dart';

class ProfilePage extends StatelessWidget {
  final String token;
  final ApplicantModel applicant;

  const ProfilePage({Key? key, required this.token, required this.applicant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                // You can load the user's photo here if available
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
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User ID', applicant.userId.toString()),
                  _buildDetailRow('Email', applicant.userEmail),
                  _buildDetailRow('Name',
                      '${applicant.firstName} ${applicant.middleName} ${applicant.lastName}'),
                  _buildDetailRow('Role', applicant.roleId.toString() == '2' ? "Applicant" : "Non-Applicant"),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Card(
            child: ListTile(
              title: Text('General Data'),
              onTap: ()  async {
                String email = applicant.userEmail;
                if(token != null){
                  Map<String, dynamic> userDetails = await UserRepository().fetchGeneralData(email,token);
                  GeneralDataModel gData = new GeneralDataModel(
                    ugDataId: userDetails['ugDataID'],
                    nis: userDetails['nis'],
                    dateBirth: userDetails['dateBirth'],
                    isScholarship: userDetails['isScholarship'],
                    scholarshipId: userDetails['schorlarshipID'] ?? 0,
                    countVerif: userDetails['countVerif'],
                    isFinal: userDetails['isFinal'],
                  );
                  print(gData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneralDataCard(gdata: gData,token: token),
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfilePage(token: token, applicant: applicant),
                  //   ),
                  // );
                }
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Academic Data'),
              onTap: () {
                // Navigate to academic data page
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Personal Data'),
              onTap: () {
                // Navigate to personal data page
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Achievement Records'),
              onTap: () {
                // Navigate to achievement records page
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('View Leaderboard'),
              onTap: () {
                // Navigate to achievement records page
              },
            ),
          ),
          SizedBox(height: 20),

        ],
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
}
