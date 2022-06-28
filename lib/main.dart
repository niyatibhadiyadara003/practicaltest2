import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practicaltest2/screens/adminpage.dart';
import 'package:practicaltest2/screens/loginpage.dart';
import 'package:practicaltest2/screens/registerpage.dart';

import 'helpers/firebasehelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'registerpage',
    routes: {
      '/': (context) => const HomePage(),
      'registerpage': (context) => const RegisterPage(),
      'loginpage': (context) => const LoginPage(),
      '/adminpage': (context) => const AdminPage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
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
                            ],
                          ),
                          Text(
                            "Role: ${docs[i]['role']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
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
