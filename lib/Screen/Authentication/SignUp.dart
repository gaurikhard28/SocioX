import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio_x/Providers/AuthProvide.dart';

import '../../Providers/NewsProvider.dart';
import '../../Utils/constants.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({required this.toggleView});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    SizeConfig().init(context);
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.defaultSize * 3,
                  right: SizeConfig.defaultSize * 3),
              child: Form(
                key: authProvider.formKey,
                child: Container(
                    margin:
                    EdgeInsets.only(top: SizeConfig.defaultSize * 10),
                  padding: EdgeInsets.only(
                      top: SizeConfig.defaultSize * 4,
                      bottom: SizeConfig.defaultSize * 2,
                      left: SizeConfig.defaultSize * 2,
                      right: SizeConfig.defaultSize * 2),
                  //height: SizeConfig.defaultSize * 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: authProvider.nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: primaryColor),
                          prefixIcon: Icon(
                            Icons.mail,
                            size: SizeConfig.defaultSize * 2,
                            color: primaryColor,
                          ),
                          filled: true,

                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: primaryColor)),
                        ),
                            validator:(value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      TextFormField(
                        controller: authProvider.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: primaryColor),
                          prefixIcon: Icon(
                            Icons.person,
                            size: SizeConfig.defaultSize * 2,
                            color: primaryColor,
                          ),
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: primaryColor)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      TextFormField(
                        controller: authProvider.contactController,
                        decoration: InputDecoration(
                          labelText: 'Contact No.',
                          labelStyle: TextStyle(color: primaryColor),
                          prefixIcon: Icon(
                            Icons.mail,
                            size: SizeConfig.defaultSize * 2,
                            color: primaryColor,
                          ),
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: primaryColor)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      TextFormField(
                        controller: authProvider.passwordController,

                        decoration: InputDecoration(

                          labelText: 'Password',
                          labelStyle: TextStyle(color: primaryColor),
                          prefixIcon: Icon(
                            Icons.lock,

                            size: SizeConfig.defaultSize * 2,
                            color: primaryColor,
                          ),
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(color: primaryColor)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                ),
                      SizedBox(
                        height: SizeConfig.defaultSize ,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: authProvider.agreedToTerms,
                            onChanged: (value) {
                              setState(() {
                                authProvider.agreedToTerms = value!;
                              });
                            },
                          ),
                          Text("I agree with terms and conditions"),
                        ],
                      ),
                        SizedBox(
                        height: SizeConfig.defaultSize ,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}
