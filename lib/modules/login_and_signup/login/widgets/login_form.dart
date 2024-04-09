import 'package:article_web/modules/home/home_page.dart';
import 'package:article_web/modules/login_and_signup/signup/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  GlobalKey<FormState> formKey;
  LoginForm({super.key, required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'purvang@gmail.com';
    _passwordController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    double formPadding = MediaQuery.sizeOf(context).width / 9;
    if (MediaQuery.sizeOf(context).width < 1000) {
      formPadding = MediaQuery.sizeOf(context).width / 6;
    }
    return Container(
      color: const Color.fromRGBO(21, 21, 21, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: formPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._formHeader(),
            _emailField,
            const SizedBox(height: 16),
            _passwordField,
            const SizedBox(height: 32),
            _getStartedButton(context),
            const SizedBox(height: 8),
            _createAccountButton(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _formHeader() {
    return [
      const Text(
        "Welcome To Content Craft",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        "Please enter your login credentials to continue",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 36),
    ];
  }

  get _emailField => TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            print('enter email');
            return 'Please enter your email.';
          }
          return null;
        },
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromRGBO(220, 199, 129, 1.0),
          ),
          labelText: "Email address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white38),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      );

  get _passwordField => TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromRGBO(220, 199, 129, 1.0),
          ),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white38),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password.';
          }
          return null;
        },
      );

  _getStartedButton(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        if(widget.formKey.currentState!.validate()){
          try {
            final credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
            if (credential.user != null) {
            } else {
              print('Please Enter Valid Credential');
            }
          } catch (e) {
            print(e);
          }
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        minimumSize: const Size.fromHeight(56),
      ),
      child: const Text(
        "Let's get started",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  _createAccountButton(BuildContext context) => TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        style: TextButton.styleFrom(
          surfaceTintColor: Colors.transparent,
        ),
        child: const Text(
          "Don't have Account? Create one.",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      );
}
