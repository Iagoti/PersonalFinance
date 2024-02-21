// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_finance/screens/sign_up.dart';
import 'package:personal_finance/services/auth_service.dart';
import 'package:personal_finance/utils/appvalidator.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "email": emailController.text,
        "password": passwordController.text
      };

      await authService.login(data, context);
      setState(() {
        isLoader = false;
      });
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
                    "Login account",
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
                            : Text("Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 252, 251, 251),
                                    fontSize: 20)))),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpView(),
                        ),
                      );
                    },
                    child: Text(
                      "Create new account",
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
