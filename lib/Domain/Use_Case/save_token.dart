import 'package:hive/hive.dart';

Future<void> saveToken(String token) async {
  var box = await Hive.openBox('tokens');
  await box.put('token', token);
}