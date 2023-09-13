import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio_x/Service/firebase_services.dart';
import '../../Providers/AuthProvide.dart';
import '../../Providers/NewsProvider.dart';
import '../../Utils/constants.dart';
import '../HomePage.dart';
import 'PasswordRecovey.dart';
import 'SignUp.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({required this.toggleView});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    void _handleForgotPassword() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordRecoveryPage()),
      );
    }
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.defaultSize * 3,
                right: SizeConfig.defaultSize * 3),
            child: Form(
              child: Container(
                margin:
                EdgeInsets.only(top: SizeConfig.defaultSize * 10),
                padding: EdgeInsets.only(
                    top: SizeConfig.defaultSize * 6,
                    bottom: SizeConfig.defaultSize * 2,
                    left: SizeConfig.defaultSize * 2,
                    right: SizeConfig.defaultSize * 2),
                height: SizeConfig.defaultSize * 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: authProvider.emailController,
                      // Added controller
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    TextFormField(
                      controller: authProvider.passwordController,
                      // Added controller
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
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
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
                        onTap:  _handleForgotPassword,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 4,
                    ),
                    Text(
                      "Login with ",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async{
                              await FirebaseService().signInWithFacebook();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                            },
                            child: AppIcons.facebook),
                        SizedBox(width: 20),
                        GestureDetector(
                            onTap: () async{
                              await FirebaseService().signInWithGoogle();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                            },
                            child: AppIcons.google),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Sign Up',
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