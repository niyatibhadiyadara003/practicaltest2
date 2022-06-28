import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practicaltest2/model/usermodel.dart';

import '../helpers/firebasehelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginkey = GlobalKey();
  TextEditingController emaillogincontroller = TextEditingController();
  TextEditingController passwordlogincontroller = TextEditingController();

  String? email;
  String? password;

  var fetchdata;

  @override
  initState() {
    super.initState();
    getdata();
  }

  getdata() async {}

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFtvcSbabMJGm7CIm4raU70TuR3TFJ9NmVMA&usqp=CAU',
              height: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: loginkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: emaillogincontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter email first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Enter your email",
                        label: const Text("Email"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: passwordlogincontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter password first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Enter your password",
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Colors.indigoAccent,
                    onPrimary: Colors.white),
                onPressed: () async {
                  QuerySnapshot<Map<String, dynamic>> data =
                      await Firebasehelper.firebaseFirestore
                          .collection('users')
                          .get();

                  fetchdata = data.docs;
                  setState(() {
                    if (loginkey.currentState!.validate()) {
                      loginkey.currentState!.save();

                      for (int i = 0; i <= fetchdata.length; i++) {
                        print(i);
                        print(fetchdata.length);
                        print(fetchdata[i]['password']);
                        print(fetchdata[i]['email']);

                        if (fetchdata[i]['email'] == email) {
                          if (fetchdata[i]['password'] == password) {
                            if (fetchdata[i]['role'] == "admin") {
                              print("............................");
                              Navigator.of(context).pushReplacementNamed(
                                  '/adminpage',
                                  arguments: args);
                            } else {
                              print(args);
                              Navigator.of(context)
                                  .pushReplacementNamed('/', arguments: args);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Password Not Match"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password Not Match"),
                            ),
                          );
                        }
                      }
                    }
                  });
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an Account?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('registerpage');
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
