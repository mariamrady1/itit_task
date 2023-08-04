
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mariamproject/view/auth/register.dart';

import '../home.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();

  String _password = '';
  String _email = '';
  bool hidePassword = true ;

  _logIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }), (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: Stack(alignment: AlignmentDirectional.topCenter, children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                    child: Image.asset(
                      'assets/images/mariam.jpg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Hello!',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          //border: OutlineInputBorder(),
                          // label: Text('Email'),
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "You must enter an email";
                          } else if (!value.contains('@gmail.com')) {
                            return "Email must contain @gmail.com";
                          } else if (value.length <= "@gmail.com".length) {
                            return "You should enter a valid email";
                          }
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          // label: Text('Password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.black,
                              icon: hidePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            ),
                            hintText: 'Enter your password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password can not be empty';
                          } else if (value.length < 8) {
                            return "Password should be more than 8 character";
                          }
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 300,
                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(50))),
                              child: GestureDetector(
                                onTap: () {
                                  _logIn(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_)=> Register())
                          );
                        },
                        child: const Text('Don\'t have an account'),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
