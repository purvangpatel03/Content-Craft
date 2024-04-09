import 'package:article_web/modules/login_and_signup/signup/widgets/signup_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double formPadding = MediaQuery.sizeOf(context).width / 9;
    if (MediaQuery.sizeOf(context).width < 1000) {
      formPadding = MediaQuery.sizeOf(context).width / 5;
    }
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        color: const Color.fromRGBO(21, 21, 21, 1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: formPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._formHeader(),
              _fullName,
              const SizedBox(height: 16,),
              _emailField,
              const SizedBox(height: 16),
              _passwordField,
              const SizedBox(height: 32),
              _createAccountButton(context),
              const SizedBox(height: 16),
              const GoogleSignup(),
              const SizedBox(height: 8),
              _haveAccount(context),
            ],
          ),
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

  get _fullName => TextFormField(
    controller: _fullNameController,
    style: const TextStyle(
      color: Colors.white
    ),
    decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Color.fromRGBO(220, 199, 129, 1.0),
        ),        labelText: "Full Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white38),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16),
    ),
  );

  get _emailField => TextFormField(
    style: const TextStyle(
        color: Colors.white
    ),
    controller: _emailController,
    decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Color.fromRGBO(220, 199, 129, 1.0),
        ),      labelText: "Email address",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white38),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 16)),
  );

  get _passwordField => TextFormField(
    style: const TextStyle(
        color: Colors.white
    ),
    obscureText: true,
    controller: _passwordController,
    decoration: InputDecoration(
      labelStyle: const TextStyle(
        color: Color.fromRGBO(220, 199, 129, 1.0),
      ),  labelText: "Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white38),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
    ),
  );

  _createAccountButton(BuildContext context){
    return FilledButton(
      onPressed: () async{
        try{
          UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
          await FirebaseAuth.instance.signOut();
          if( credential.user != null ){
            Navigator.pop(context);
          }
        }
        catch(e){
          print(e);
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        minimumSize: const Size.fromHeight(56),
      ),
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
  _haveAccount(BuildContext context) => TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    style: TextButton.styleFrom(
      surfaceTintColor: Colors.transparent,
    ),
    child: const Text(
      "Have Account? Login.",
      style: TextStyle(
        color: Colors.white54,
        fontSize: 14,
      ),
    ),
  );
}
