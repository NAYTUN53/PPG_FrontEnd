import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/controller/auth_controller.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/custom_scaffold_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final _authController = AuthController();
  late String email;
  late String fullName;
  String role = "Admin";
  late String password;

  signUpUser() async {
    setState(() {
      isLoading = true;
    });
    if(!mounted) return;
    await _authController
        .signUpUsers(
            context: context,
            fullName: fullName,
            email: email,
            role: role,
            password: password)
        .whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Column(
        children: [
          const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Text
                          Center(
                            child: Text("Welcome to PWAR PWAR GYI",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 246, 138, 38))),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          // Username TextFormField
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                fullName = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter username!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: const Text("Username"),
                                hintText: "Username",
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10))),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Email Text form field
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: const Text("Email"),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10))),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Choose your role :",
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton<String>(
                                value: role,
                                icon: const Icon(
                                  size: 40,
                                  Icons.arrow_drop_down,
                                ),
                                style: const TextStyle(color: Colors.white),
                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    role = value!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(
                                      value: "Admin",
                                      child: Text(
                                        "Admin",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: "Branch1",
                                      child: Text(
                                        "Branch1",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: "Branch2",
                                      child: Text(
                                        "Branch2",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: "Branch3",
                                      child: Text(
                                        "Branch3",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: "Branch4",
                                      child: Text(
                                        "Branch4",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                  DropdownMenuItem(
                                      value: "Branch5",
                                      child: Text(
                                        "Branch5",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Password TextFormField
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: const Text("Password"),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(10))),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Login Button
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                signUpUser();
                              } else {}
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 3, 51, 84)),
                              child: Center(
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Register",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Already have an account? Click Here",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const Center(
                            child: Text(
                              "Powerd by Versa Studio",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
