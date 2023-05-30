
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  String? _fullName;
  String? _email;
  String? _password;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50,),
          _buildLogoWidget,
          SizedBox(height: 20,),
          Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFullNameWidget,
                  _buildEmailWidget,
                  _buildPasswordWidget,
                  SizedBox(height: 20.0),
                  _buildRegisterButtonWidget,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already exist account ?',
                        // style: _textStyleGrey,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Sign In',
                          // style: _textStyleBlueGrey,
                        ),
                      )
                    ],
                  ),
                ],
              )
          )
        ],
      ),
    );
  }


  // Register With Email


  // Register With PhoneNumber


  Widget get _buildLogoWidget {
    return Container(
        child: Column(
          children: [
            Image.asset('assets/logo.png', width: 100, height: 100,),
            SizedBox(height: 10),
            Text("Welcome to WiDcy Institute", style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        )
    );
  }

  Widget get _buildFullNameWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Full Name'),
        validator: (input) => input!.trim().isEmpty
            ? 'Please enter a valid full name !'
            : null,
        onSaved: (input) => _fullName = input!,
      ),
    );
  }

  Widget get _buildEmailWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (input) => !input!.contains('@')
            ? 'Please enter a valid email'
            : null,
        onSaved: (input) => _email = input!,
      ),
    );
  }

  Widget get _buildPasswordWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        validator: (input) => input!.length < 6
            ? 'Must be at least 6 characters'
            : null,
        onSaved: (input) => _password = input!,
        obscureText: true,
      ),
    );
  }

  Widget get _buildRegisterButtonWidget {
    return Padding(
      padding: EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Container(
        width: double.infinity,
        color: Colors.blue,
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : TextButton(
          onPressed: () => {
            register("chhaichivon1995@gmail.com", "123456")
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredential.user != null){
        print("Success");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
