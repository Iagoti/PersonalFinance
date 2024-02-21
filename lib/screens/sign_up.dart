// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:personal_finance/screens/dashboard.dart';
import 'package:personal_finance/screens/login.dart';
import 'package:personal_finance/services/auth_service.dart';
import 'package:personal_finance/utils/appvalidator.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var authService = AuthService();
  var isLoader = false;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": userNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text
      };

      await authService.createUser(data, context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
      setState(() {
        isLoader = false;
      });
      // ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(
      //   const SnackBar(content: Text("Form submit sucess")),
      // );
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252634),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Create new account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: userNameController,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration('User Name', Icons.person),
                  validator: appValidator.validateUserName,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration('Email', Icons.email),
                  validator: appValidator.validateEmail,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration('Phone Number', Icons.phone),
                  validator: appValidator.validatePhoneNumber,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration('Password', Icons.lock),
                  validator: appValidator.validatePassword,
                ),
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 204, 89, 0)),
                        onPressed: () {
                          isLoader ? print("Carregando...") : submitForm();
                        },
                        child: isLoader
                            ? Center(child: CircularProgressIndicator())
                            : Text("Create",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 252, 251, 251),
                                    fontSize: 20)))),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Color(0xfff15900), fontSize: 20),
                    ))
              ],
            ),
          ),
        ));
  }

  InputDecoration buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color(0xaa494a59),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff949494))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        filled: true,
        labelStyle: TextStyle(color: Color(0xff949494)),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Color(0xff949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
