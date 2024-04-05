import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:schooladn_rev/Data/datasource/production_source.dart';
import 'package:schooladn_rev/Data/datasource/source.dart';
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Use_Case/get_userData.dart';
import 'package:schooladn_rev/Domain/Use_Case/save_token.dart';
import 'package:schooladn_rev/Presentation/profile_page.dart';
import 'package:schooladn_rev/Presentation/register_page.dart'; // Import RegisterPage

final getIt = GetIt.instance;

void setup(){
  getIt.registerSingleton<Source>(ProductionSource());
}

void main() async{
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 230,
                height: 230,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String token = await UserRepository().login({
                      'email': emailController.text,
                      'password': passwordController.text,
                    });
                    print(token);
                    if(token != null){
                      await saveToken(token);
                      ApplicantModel applicant = await getUserData(token, emailController.text);
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
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Change button color to orange
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Make button rounded
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Change text color to white
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  'Don\'t have an account? Register here',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
