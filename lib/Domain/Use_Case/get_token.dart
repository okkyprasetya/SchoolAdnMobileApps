import 'package:hive/hive.dart';

Future<String?> getToken() async {
  var box = await Hive.openBox('token');
  return box.get('token');
}