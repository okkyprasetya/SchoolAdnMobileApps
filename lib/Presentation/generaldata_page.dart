import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/Repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/generalDataModel.dart';
import 'package:schooladn_rev/Domain/Entities/scholarshipDataModel.dart';

class GeneralDataCard extends StatefulWidget {
  final GeneralDataModel gdata;
  final String token;

  const GeneralDataCard({
    Key? key,
    required this.gdata,
    required this.token,
  }) : super(key: key);

  @override
  _GeneralDataCardState createState() => _GeneralDataCardState();
}

class _GeneralDataCardState extends State<GeneralDataCard> {
  late TextEditingController _nisController;
  late TextEditingController _dobController;
  late TextEditingController _scholarshipIdController;
  late TextEditingController _verifiedStatusController;
  late TextEditingController _statusController;
  late int ugDataId;

  bool _isEditing = false;
  var newData;

  @override
  void initState() {
    super.initState();
    ugDataId = widget.gdata.ugDataId.toInt();
    _nisController = TextEditingController(text: widget.gdata.nis ?? "Not set yet");
    _dobController = TextEditingController(text: widget.gdata.dateBirth ?? "Not set yet");
    if(widget.gdata.scholarshipId == 1){
      _scholarshipIdController = TextEditingController(text: 'Rotary Peace Fellowship');
    }
    else if(widget.gdata.scholarshipId == 2){
      _scholarshipIdController = TextEditingController(text: 'Rhodes Scholarship');
    }
    else if(widget.gdata.scholarshipId == 3){
      _scholarshipIdController = TextEditingController(text: 'Chevening Scholarship');
    }
    else{
      _scholarshipIdController = TextEditingController(text: 'Not set yet');
    }

    _verifiedStatusController = TextEditingController(text: widget.gdata.countVerif.toInt() < 2 ? "Verify on process" : "All necessary document has been verified");
    _statusController = TextEditingController(text: widget.gdata.isFinal.toString() == "false" ? "Not Finalize Yet" : "Data has been finalized");
  }

  @override
  void dispose() {
    _nisController.dispose();
    _dobController.dispose();
    _scholarshipIdController.dispose();
    _verifiedStatusController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'General Data',
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
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'General Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12),
                _buildTableRow('NIS', _nisController),
                _buildTableRow('Date of Birth', _dobController),
                _buildScholarshipDropDown(),
                _buildReadOnlyTableRow('Verified Status', _verifiedStatusController),
                _buildReadOnlyTableRow('Status', _statusController),
                SizedBox(height: 12),
                if (!_isEditing)
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.orange, // Setting button color to orange
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      child: Icon(Icons.edit, color: Colors.white), // Setting icon color to white
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _isEditing
                      ? FloatingActionButton(
                    backgroundColor: Colors.orange, // Setting button color to orange
                    onPressed: () {
                      _saveChanges();
                    },
                    child: Icon(Icons.save, color: Colors.white), // Setting icon color to white
                  )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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

  Widget _buildScholarshipDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Scholarship :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _isEditing
                ? FutureBuilder<List<ScholarshipDataModel>>(
              future: UserRepository().fetchScholarshipName(widget.token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return DropdownButtonFormField<String>(
                    value: newData,
                    items: snapshot.data!.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.scholarshipId.toString(),
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _scholarshipIdController.text = value ?? ""; // Update the controller value
                        newData = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  );
                }
              },
            )
                : TextField(
              controller: _scholarshipIdController,
              readOnly: true,
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

  Widget _buildReadOnlyTableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              readOnly: true,
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

  void _saveChanges() {
    int scholarshipId = (_scholarshipIdController.text.isNotEmpty)
        ? int.tryParse(_scholarshipIdController.text) ?? 0
        : 0;

    GeneralDataEditModel generalDataEdit = GeneralDataEditModel(
      ugDataId: ugDataId,
      nis: _nisController.text,
      dateBirth: _dobController.text,
      isScholarship: true,
      scholarshipId: scholarshipId,
    );

    UserRepository().editGeneralData(ugDataId, widget.token, generalDataEdit);

    setState(() {
      _isEditing = false;
    });
  }
}
