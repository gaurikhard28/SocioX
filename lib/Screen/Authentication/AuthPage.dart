import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio_x/Screen/HomePage.dart';
import 'package:socio_x/Utils/constants.dart';

import '../../Providers/AuthProvide.dart';
import '../../Providers/NewsProvider.dart';
import 'SignIn.dart';
import 'SignUp.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    void _submitForm() {}
    return Scaffold(
      appBar: AppBar(
        title: Text('SocioX'),
        backgroundColor: SecondaryColor,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: showSignIn
                ? SignInPage(
                    toggleView: toggleView,
                  )
                : SignUpPage(toggleView: toggleView),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Spread to the total width of the screen
              decoration: BoxDecoration(
                color: SecondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleButtons(
                    renderBorder: false,
                    constraints: BoxConstraints.expand(
                        width: MediaQuery.of(context).size.width /
                            2), //number 2 is number of toggle buttons
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    isSelected: [showSignIn, !showSignIn],
                    selectedColor: primaryColor,
                    onPressed: (index) {
                      setState(() {
                        showSignIn = index == 0;
                      });
                    },
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity, // Spread to the total width of the screen
              decoration: BoxDecoration(
                color: SecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // No corner radius
                  ),
                  primary: SecondaryColor,
                  onPrimary: textColor,
                ),
                onPressed: () {
                  if (showSignIn) {
                    print(authProvider.emailController);
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: authProvider.emailController.text,
                            password: authProvider.passwordController.text)
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage())))
                        .onError(
                            (error, stackTrace) => print(error.toString()));
                  } else {
                    print(authProvider.emailController.text);
                    if (authProvider.formKey.currentState!.validate()) {
                      if (authProvider.agreedToTerms) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: authProvider.emailController.text,
                                password: authProvider.passwordController.text)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage())))
                            .onError(
                                (error, stackTrace) => print(error.toString()));
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Terms and Conditions'),
                            content: Text(
                                'Please agree to the terms and conditions before registering.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text(
                  showSignIn ? 'Sign In' : 'Register',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
