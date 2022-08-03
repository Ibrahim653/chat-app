import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_field.dart';
import '../constants.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
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
                      "LOGIN",
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
                        await loginUser();
                        Navigator.pushReplacementNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                              context, 'Wrong password provided for that user');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                    } else {}
                    isLoading = false;
                    setState(() {});
                  },
                  text: "LOGIN",
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You don't have an account ?"),
                    TextButton(
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, RegisterPage.id),
                        child: const Text(
                          "   Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
