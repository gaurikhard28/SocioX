import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




}