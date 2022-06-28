import 'package:flutter/material.dart';
import 'package:practicaltest2/helpers/firebasehelper.dart';
import 'package:practicaltest2/model/usermodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerkey = GlobalKey();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController rolecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String? username;
  String? email;
  String? password;
  String? role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.allen.ac.in/apps2223/assets/images/reset-password.jpg',
              height: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: registerkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: usernamecontroller,
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Enter your username",
                        label: const Text("User name"),
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
                      controller: emailcontroller,
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
                      controller: passwordcontroller,
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: rolecontroller,
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Enter your role",
                        label: const Text("Role"),
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
                onPressed: () {
                  setState(() {
                    if (registerkey.currentState!.validate()) {
                      registerkey.currentState!.save();

                      Usermodel data = Usermodel(
                          username: username,
                          password: password,
                          role: role,
                          email: email);
                      Firebasehelper.firebasehelper.insertdb(data: data);

                      Navigator.of(context)
                          .pushReplacementNamed('loginpage', arguments: data);
                    }
                  });
                },
                child: const Text(
                  "Sign Up",
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
                  "Already have an Account?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('loginpage');
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
