import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mariamproject/view/main_screens/my_profile.dart';

import '../home.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();

  String _password = '';
  String _email = '';
  String _userName = '';
  String _status = '';
  XFile ? _image ;
  String ? _imageUrl ;
  final ImagePicker picker = ImagePicker();
  bool hidePassword = true;
  bool hideConfirmedPassword = true;

  _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(_image == null){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('please pick your personal image'),
          backgroundColor: Colors.red,
        ));
        return ;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        _uploadImage().then((value) {
          _uploadData();
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }), (route) => false);
        });

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

  Future<void> _uploadImage() async{
    String key = UniqueKey().toString();
    await FirebaseStorage.instance.ref().child('users_image/$key').putFile(File(_image!.path));
    _imageUrl = await FirebaseStorage.instance.ref().child('users_image/$key').getDownloadURL();
  }

  _uploadData() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(id).set({
        "id": id,
        "email": _email,
        "name":_userName ,
        "status": _status ,
        "image_url": _imageUrl ,
    });
  }
  pickImage(bool isCamera) async {
    _image = await picker.pickImage(source:isCamera? ImageSource.camera : ImageSource.gallery);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Image picked successfully'),
      backgroundColor: Colors.green,
    ));
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
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You must enter your name";
                      } else if (value.length <= 3) {
                        return "You should enter a valid name";
                      }
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
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
                  TextFormField(
                    obscureText: hideConfirmedPassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hideConfirmedPassword = !hideConfirmedPassword;
                            });
                          },
                          icon: hideConfirmedPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        ),
                        // border: OutlineInputBorder(),
                        // label: Text('Password'),
                        hintText: 'Confirm password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can not be empty';
                      } else if (value != _passwordController.text) {
                        return "Password doesn't match";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Status'),
                    maxLines: 2,
                    onSaved: (value){
                      _status = value ??'';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (_)=> AlertDialog(
                              title: const Text('Pick Image',textAlign: TextAlign.center,),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(onPressed: (){
                                    pickImage(true);
                                  },
                                      child: const Text('Camera'),
                                  ),
                                  const SizedBox(width: 10,),
                                  TextButton(onPressed: (){
                                    pickImage(false);
                                  },
                                    child: const Text('Gallary'),
                                  ),
                                ],
                              ),
                            ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orange),
                          foregroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      child: const Text('Pick Image',) ,
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
                              _register(context);
                            },
                            child: const Text(
                              'Register',
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Already have an account'),
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
