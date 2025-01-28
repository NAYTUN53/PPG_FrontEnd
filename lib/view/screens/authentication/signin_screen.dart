import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/controller/auth_controller.dart';
import 'package:pwar_pwar_gyi_app/view/screens/authentication/register_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/custom_scaffold_widget.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? rememberPassword = false;
  bool isLoading = false;
  late String email;
  late String password;
  final _authController = AuthController();

  signInUser() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    if(!mounted) return;
    await _authController
        .signInUsers(
            context: context, email: email, password: password, ref: ref)
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
                                    color: MyColor.color1)),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          // Email TextFormField
                          TextFormField(
                            onChanged: (value) {
                              email = value;
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

                          // Password TextFormField
                          TextFormField(
                            onChanged: (value) {
                              password = value;
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
                            height: 10,
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: Colors.deepPurple,
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),

                          // Checkbox, Remember me, Forget password

                          const SizedBox(
                            height: 10,
                          ),

                          // Login Button
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                signInUser();
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
                                        "Sign In",
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const RegisterScreen();
                              }));
                            },
                            child: const Text(
                              "Create an account? Click Here",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          const Center(
                            child: Text(
                              "Powered by Versa Studio",
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
