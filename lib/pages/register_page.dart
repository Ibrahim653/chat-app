import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/services/auth.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_field.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 25),
                    Image.asset(
                      kLogo,
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Chat FCI",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 75),
                    Row(
                      children: const [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                        onChanged: (data) {
                          email = data;
                        },
                        hinText: "Email"),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                        obscureText: true,
                        onChanged: (data) {
                          password = data;
                        },
                        hinText: "Password"),
                    const SizedBox(height: 10),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await registerUser();
                            Navigator.pushReplacementNamed(
                                context, LoginPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context, 'weak-password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(
                                  context, 'The account is already exists');
                            }
                          } catch (e) {
                            showSnackBar(context, 'there was an error');
                          }
                        } else {}
                        isLoading = false;
                        setState(() {});
                      },
                      text: "Sign Up",
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        AuthMethods().signWithGoogle(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.06),
                            const Text(
                              "Sign Up with Google",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account"),
                        TextButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "   LOGIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
