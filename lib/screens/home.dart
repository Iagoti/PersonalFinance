// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance/screens/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isLogoutLoading = false;
  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );

    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 96, 243),
        title: Text(
          "Hello, ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(Icons.exit_to_app, color: Colors.white),
            color: Color.fromARGB(255, 252, 252, 253),
          )
        ],
      ),
      body: Container(
          width: double.infinity,
          color: Color.fromARGB(255, 42, 96, 243),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Balance",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          height: 1.2,
                          fontWeight: FontWeight.w600)),
                  Text("R 98.000",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          height: 1.2,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      CardOne(
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CardOne(
                        color: Colors.red,
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color.withOpacity(0.1),
        child: Row(
          children: [
            Column(
              children: [Text("Credit"), Text("RS 5.850")],
            )
          ],
        ),
      ),
    );
  }
}
