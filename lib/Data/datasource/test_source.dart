import 'package:schooladn_rev/Data/datasource/source.dart';

class TestSource extends Source{
  @override
  Future<String> login(Map<String, dynamic> user) async{
    // TODO: implement login
    return 'Test Login';
  }
}