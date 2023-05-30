import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/auth_service.dart';
import 'package:firebase_demo/home_screen.dart';
import 'package:firebase_demo/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: _buildBodyWidget
    );
  }

  Widget get _buildLogoWidget {
    return Container(
        child: Column(
      children: [
        Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
        SizedBox(height: 10),
        Text(
          "Welcome to WiDcy Institute",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ));
  }

  Widget get _buildEmailWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: TextField(
        controller: _emailController,
        decoration: new InputDecoration(
            hintText: 'Phone number, email or username',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
            ),
            isDense: true),
      ),
    );
  }

  Widget get _buildPasswordWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            isDense: true),
        obscureText: true,
      ),
    );
  }

  Widget get _loginWidget {
    return GestureDetector(
      // onTap: _logInUser,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10.0),
        width: 500.0,
        height: 40.0,
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            :  Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }

  Widget get _facebookLoginWidget {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: GestureDetector(
        onTap: null,
        child: Text(
          "Log in with facebook",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget get _buildBodyWidget {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLogoWidget,
          _buildEmailWidget,
          _buildPasswordWidget,
          _loginWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Do not have account yet ?',
                // style: _textStyleGrey,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'Sign Up',
                  // style: _textStyleBlueGrey,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ' OR ',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          _facebookLoginWidget
        ],
      ),
    );
  }

  _showEmptyDialog(String title) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    }
  }

  void _logInUser() async {
    if (_emailController.text.isEmpty) {
      _showEmptyDialog("Type something");
    } else if (_passwordController.text.isEmpty) {
      _showEmptyDialog("Type something");
    }
    setState(() {
      _isLoading = true;
    });
    String result = await AuthService().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (result == 'successs') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
  }



  // Login with phone number
  void loginWithPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {

      },
      verificationFailed: (FirebaseAuthException e) {
        
      },
      codeSent: (String verificationId, int? resendToken) {

      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }
}
