import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Domain/Entities/personalDataModel.dart';

class PersonalDataPage extends StatefulWidget {
  final PersonalDataModel personalData; // Assuming your personal data model is named PersonalData
  final String token;

  const PersonalDataPage({
    Key? key,
    required this.personalData,
    required this.token,
  }) : super(key: key);

  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  late TextEditingController _fatherNameController;
  late TextEditingController _fatherAddressController;
  late TextEditingController _fatherJobController;
  late TextEditingController _fatherSalaryController;
  late TextEditingController _motherNameController;
  late TextEditingController _motherAddressController;
  late TextEditingController _motherJobController;
  late TextEditingController _motherSalaryController;
  late TextEditingController _siblingsNumberController;
  late TextEditingController _hobiController;
  late TextEditingController _kkDocumentController;
  late TextEditingController _birthDocumentController;
  late TextEditingController _isVerifiedController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    PersonalDataModel data = widget.personalData;
    _fatherNameController = TextEditingController(text: data.fatherName == "" ? "Not set yet.":data.fatherName);
    _fatherAddressController = TextEditingController(text: data.fatherAddress == "" ? "Not set yet.":data.fatherAddress);
    _fatherJobController = TextEditingController(text: data.fatherJob == "" ? "Not set yet.":data.fatherJob);
    _fatherSalaryController = TextEditingController(text: data.fatherSalary.toString() == "0" ? "Not set yet.":data.fatherSalary.toString());
    _motherNameController = TextEditingController(text: data.motherName == "" ? "Not set yet.":data.motherName);
    _motherAddressController = TextEditingController(text: data.motherAddress == "" ? "Not set yet.":data.motherAddress);
    _motherJobController = TextEditingController(text: data.motherJob == "" ? "Not set yet.":data.motherJob);
    _motherSalaryController = TextEditingController(text: data.motherSalary.toString() == "0" ? "Not set yet.":data.motherSalary.toString());
    _siblingsNumberController = TextEditingController(text: data.siblingsNumber.toString() == "0" ? "Not set yet.":data.siblingsNumber.toString());
    _hobiController = TextEditingController(text: data.hobi == "" ? "Not set yet.":data.hobi );
    _kkDocumentController = TextEditingController(text: data.kkDocument == "" ? "Not uploaded yet.":data.kkDocument);
    _birthDocumentController = TextEditingController(text: data.birthDocument == "" ? "Not uploaded yet.":data.birthDocument);
    _isVerifiedController = TextEditingController(text: data.isVerified ? "Verified" : "Not verified yet");
  }

  @override
  void dispose() {
    _fatherNameController.dispose();
    _fatherAddressController.dispose();
    _fatherJobController.dispose();
    _fatherSalaryController.dispose();
    _motherNameController.dispose();
    _motherAddressController.dispose();
    _motherJobController.dispose();
    _motherSalaryController.dispose();
    _siblingsNumberController.dispose();
    _hobiController.dispose();
    _kkDocumentController.dispose();
    _birthDocumentController.dispose();
    _isVerifiedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Personal Data',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard('Father Data', [
              _buildDataRow('Father Name', _fatherNameController),
              _buildDataRow('Father Address', _fatherAddressController),
              _buildDataRow('Father Job', _fatherJobController),
              _buildDataRow('Father Salary', _fatherSalaryController),
            ]),
            _buildCard('Mother Data', [
              _buildDataRow('Mother Name', _motherNameController),
              _buildDataRow('Mother Address', _motherAddressController),
              _buildDataRow('Mother Job', _motherJobController),
              _buildDataRow('Mother Salary', _motherSalaryController),
            ]),
            _buildCard('Other Details', [
              _buildDataRow('Number of Siblings', _siblingsNumberController),
              _buildDataRow('Hobby', _hobiController),
              _buildDataRow('KK Document', _kkDocumentController),
              _buildDataRow('Birth Document', _birthDocumentController),
              _buildDataRow('Is Verified', _isVerifiedController),
            ]),
            SizedBox(height: 16),
            _buildEditButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              readOnly: !_isEditing,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        backgroundColor: Colors.orange, // Set button background color to orange
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
          });
          if (_isEditing) {
            _saveData(widget.personalData.ugDataId, widget.token, PersonalDataModel(
                ugDataId: widget.personalData.ugDataId,
                upDataId: widget.personalData.upDataId,
                fatherName: _fatherNameController.text,
                fatherAddress: _fatherAddressController.text,
                fatherJob: _fatherJobController.text,
                fatherSalary: int.parse(_fatherSalaryController.text),
                motherName: _motherNameController.text,
                motherAddress: _motherAddressController.text,
                motherJob: _motherJobController.text,
                motherSalary: int.parse(_motherSalaryController.text),
                siblingsNumber: int.parse(_siblingsNumberController.text),
                hobi: _hobiController.text,
                kkDocument: _kkDocumentController.text,
                birthDocument: _birthDocumentController.text,
                isVerified: false
            ));
          }
        },
        child: _isEditing ? Icon(Icons.save, color: Colors.white) : Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  void _saveData(int ugdataid, String token, PersonalDataModel data) async{
    if(widget.personalData.upDataId == 0){
      await ProductionSource().completePersonalData(ugdataid, token, data);
    }
    else{
      await ProductionSource().updatePersonalData(ugdataid, token, data);
    }
  }
}
