import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Domain/Entities/AcaddemicDataEditModel.dart';
import 'package:schooladn_rev/Domain/Entities/academicData.dart';

class AcademicDataCard extends StatefulWidget {
  final AcademicDataModel academicData;
  final String token;

  const AcademicDataCard({
    Key? key,
    required this.academicData,
    required this.token,
  }) : super(key: key);

  @override
  _AcademicDataCardState createState() => _AcademicDataCardState();
}

class _AcademicDataCardState extends State<AcademicDataCard> {
  late TextEditingController _raportSummariesController;
  late TextEditingController _raportDocumentController;
  late TextEditingController _isVerifiedController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _raportSummariesController = TextEditingController(
      text: widget.academicData.raportSUmmaries.toString() == "0"
          ? "Not set yet"
          : widget.academicData.raportSUmmaries.toString(),
    );
    _raportDocumentController = TextEditingController(
      text: widget.academicData.raportDocument.isEmpty
          ? "Not uploaded yet"
          : widget.academicData.raportDocument,
    );
    _isVerifiedController = TextEditingController(
      text: widget.academicData.isVerified ? "Verified" : "Not verified yet",
    );
  }

  @override
  void dispose() {
    _raportSummariesController.dispose();
    _raportDocumentController.dispose();
    _isVerifiedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Academic Data',
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
              children: [
                Text(
                  'Academic Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12),
                _buildTableRow('Raport summaries', _raportSummariesController),
                _buildTableRow('Raport Document', _raportDocumentController),
                _buildTableRow('Is Verified', _isVerifiedController),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.orange, // Set button background color to orange
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                      int raportSummaries = int.tryParse(_raportSummariesController.text) ?? 0;

                      if (_isEditing) {
                        // Call the _saveData method when editing mode is enabled
                        _saveData(widget.academicData.uagDataId, widget.token, AcademicDataEditModel(
                          uaDataId: widget.academicData.uaDataId,
                          uagDataId: widget.academicData.uagDataId,
                          raportSUmmaries: raportSummaries,
                          raportDocument: _raportDocumentController.text,
                        ));
                      }
                    },
                    child: _isEditing ? Icon(Icons.save, color: Colors.white) : Icon(Icons.edit, color: Colors.white), // Set icon color to white
                  ),
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
              readOnly: label == 'Is Verified' ? true : !_isEditing, // Set readOnly to true if label is 'Is Verified'
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

  void _saveData(int ugdataid, String token, AcademicDataEditModel data) async{
    if(widget.academicData.uaDataId == 0){
      await ProductionSource().completeAcademicData(ugdataid, token, data);
    }
    else{
      await ProductionSource().updateAcademicData(ugdataid, token, data);
    }
  }
}
