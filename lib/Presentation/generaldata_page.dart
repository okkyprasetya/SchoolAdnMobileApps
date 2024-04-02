import 'package:flutter/material.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';

class GeneralDataCard extends StatelessWidget {
  final GeneralDataModel gdata;
  final String token;

  const GeneralDataCard({
    Key? key,
    required this.gdata,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'General Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('UG Data ID', gdata.ugDataId.toString()),
            _buildDetailRow('NIS', gdata.nis ?? "Not set yet"),
            _buildDetailRow('Date of Birth', gdata.dateBirth ?? "Not set yet"),
            _buildDetailRow('Is Scholarship', gdata.isScholarship.toString() ?? "Not set yet"),
            _buildDetailRow('Scholarship ID', gdata.scholarshipId.toString() ?? "Not set yet"),
            _buildDetailRow('Verified Document', gdata.countVerif.toString() ?? "Not set yet"),
            _buildDetailRow('Status', gdata.isFinal.toString() ?? "Not Finalize Yet"),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Handle edit action
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
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
