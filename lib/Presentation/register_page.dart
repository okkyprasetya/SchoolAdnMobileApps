import 'package:flutter/material.dart';
import 'package:schooladn_rev/Data/repository/user_repository.dart';
import 'package:schooladn_rev/Domain/Entities/applicantModel.dart';
import 'package:schooladn_rev/Domain/Use_Case/get_userData.dart';
import 'package:schooladn_rev/Domain/Use_Case/register_applicant.dart';
import 'package:schooladn_rev/Domain/Use_Case/save_token.dart';
import 'package:schooladn_rev/Presentation/profile_page.dart';
import 'package:schooladn_rev/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

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
                'assets/images/logo.png', // Path to your logo image asset
                width: 150,
                height: 150,
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
              SizedBox(height: 10),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: middleNameController,
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    ApplicantModel newApp = new ApplicantModel(
                        userId: 0,
                        password: passwordController.text,
                        userEmail: emailController.text,
                        firstName: firstNameController.text,
                        middleName: middleNameController.text,
                        lastName: lastNameController.text,
                        roleId: 0);
                    await register(newApp);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
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
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Change text color to white
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back to login page
                },
                child: Text(
                  'Already have an account? Login here',
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
