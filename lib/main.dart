import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Data/datasource/source.dart';
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Use_Case/save_token.dart';
import 'package:schooladn_rev/Presentation/profile_page.dart';

final getIt = GetIt.instance;

void setup(){
  getIt.registerSingleton<Source>(ProductionSource());
}

void main() async{
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () async {
                try {
                  String token = await UserRepository().login({
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                  print(token);
                  if(token != null){
                    await saveToken(token);
                    Map<String, dynamic> userDetails = await UserRepository().fetchUserDetails(emailController.text);
                    ApplicantModel applicant = new ApplicantModel(
                        userId: userDetails['userID'],
                        userEmail: userDetails['userEmail'],
                        firstName: userDetails['firstName'],
                        middleName: userDetails['middleName'],
                        lastName: userDetails['lastName'],
                        roleId: userDetails['roleID']
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(token: token, applicant: applicant),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
