import 'dart:developer';

import 'package:cryptowallet/net/flutterfire.dart';
import 'package:cryptowallet/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.teal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/1.3,
              child: TextFormField(
                controller: _emailField,
                decoration: const InputDecoration(
                  hintText: "Enter email",
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            
            SizedBox(
              width: MediaQuery.of(context).size.width/1.3,
              height: MediaQuery.of(context).size.height/6,
              child: TextFormField(
                controller: _passwordField,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter password",
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.3,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  child: const Text("Login"),
                  onPressed: () async {
                    bool shouldNavigate =
                        await login(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      print("Login Successful");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                      // Navigate
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),

            Container(
              width: MediaQuery.of(context).size.width / 1.3,              
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    // Navigate
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
