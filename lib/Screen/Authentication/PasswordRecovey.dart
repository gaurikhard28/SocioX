import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socio_x/Service/firebase_services.dart';
import '../../Utils/constants.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController emailController = TextEditingController();
  final _auth=FirebaseAuth.instance;

  void _recoverPassword() {
    String email = emailController.text;
    _auth.sendPasswordResetEmail(email: email).then((value) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password recovery email sent to $email'),
        backgroundColor: Colors.green, // You can customize the color
      ),
    ),).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.green, // You can customize the color
      ),
    ));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Your Password?'),
        backgroundColor: SecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * 3),
                child: Form(
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                    height: SizeConfig.defaultSize * 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
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
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 3,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // No corner radius
                              ),
                              primary: SecondaryColor,
                              onPrimary: textColor,
                            ),
                          onPressed: _recoverPassword,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 58.0,vertical: 15),
                            child: Text('Submit',style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
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
