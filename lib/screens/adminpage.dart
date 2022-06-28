import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practicaltest2/model/usermodel.dart';

import '../helpers/firebasehelper.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  GlobalKey<FormState> updatekey = GlobalKey();
  TextEditingController usernameupdatecontroller = TextEditingController();
  TextEditingController roleupdatecontroller = TextEditingController();
  TextEditingController emailupdatecontroller = TextEditingController();
  TextEditingController passwordupdatecontroller = TextEditingController();

  String? username;
  String? email;
  String? password;
  String? role;

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('registerpage');
        },
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            Firebasehelper.firebaseFirestore.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${docs[i]['username']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Email: ${docs[i]['email']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Role: ${docs[i]['role']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  usernameupdatecontroller.text =
                                      docs[i]['username'];
                                  emailupdatecontroller.text = docs[i]['email'];
                                  roleupdatecontroller.text = docs[i]['role'];
                                  passwordupdatecontroller.text =
                                      docs[i]['password'];

                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: updatekey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            usernameupdatecontroller,
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return "Enter user name first";
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (val) {
                                                          setState(() {
                                                            username = val;
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          hintText:
                                                              "Enter your username",
                                                          label: const Text(
                                                              "User name"),
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.person),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            emailupdatecontroller,
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
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          hintText:
                                                              "Enter your email",
                                                          label: const Text(
                                                              "Email"),
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.person),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            passwordupdatecontroller,
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
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          hintText:
                                                              "Enter your password",
                                                          label: const Text(
                                                              "Password"),
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.person),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            roleupdatecontroller,
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return "Enter role first";
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (val) {
                                                          setState(() {
                                                            role = val;
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          hintText:
                                                              "Enter your role",
                                                          label: const Text(
                                                              "Role"),
                                                          prefixIcon:
                                                              const Icon(
                                                                  Icons.person),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (updatekey.currentState!
                                                      .validate()) {
                                                    updatekey.currentState!
                                                        .save();
                                                    Usermodel data = Usermodel(
                                                        username: username,
                                                        password: password,
                                                        role: role,
                                                        email: email);
                                                    Firebasehelper
                                                        .firebasehelper
                                                        .updatedata(
                                                            data: data,
                                                            id: docs[i].id);
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  primary: Colors.indigoAccent,
                                                ),
                                                child: const Text(
                                                  "Update",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  primary: Colors.indigoAccent,
                                                ),
                                                child: const Text(
                                                  "Cancle",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "Are you sure to delete this record?"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Firebasehelper.firebasehelper
                                                      .deletedata(
                                                          id: docs[i].id);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  primary: Colors.redAccent,
                                                ),
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  primary: Colors.indigoAccent,
                                                ),
                                                child: const Text(
                                                  "Cancle",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
