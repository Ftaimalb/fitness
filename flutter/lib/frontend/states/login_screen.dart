import 'package:fitness_app/frontend/states/index.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool hidePassword = true;
  bool registrationMode =
      false; //if false shows login form, if true shows registration form

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void login() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Index();
    }));
  }

  void register() {}

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
              height: 100,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  errorText: emailError,
                  prefixIcon: const Icon(Icons.mail_outline),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.grey, width: 2)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  //if password incorrect
                  return null;
                },
              )),
          SizedBox(
              height: 100,
              child: TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  errorText: passwordError,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.grey, width: 2)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  //if password incorrect
                  return null;
                },
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(177, 240, 246, 1),
                Color.fromRGBO(154, 197, 244, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('FitFish', style: TextStyle(fontSize: 40))],
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(154, 197, 244, 1)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    registrationMode = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                        MediaQuery.of(context).size.height * 0.06),
                    backgroundColor: registrationMode
                        ? const Color.fromRGBO(248, 248, 248, 0.5)
                        : const Color.fromRGBO(248, 248, 248, 1),
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)))),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    registrationMode = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                        MediaQuery.of(context).size.height * 0.06),
                    backgroundColor: registrationMode
                        ? const Color.fromRGBO(248, 248, 248, 1)
                        : const Color.fromRGBO(248, 248, 248, 0.5),
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)))),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
                const BoxDecoration(color: Color.fromRGBO(248, 248, 248, 1)),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  registrationMode
                      ? 'Create a new account'
                      : 'Login with an existing account',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                buildForm(),
                ElevatedButton(
                  onPressed: registrationMode ? register : login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    fixedSize: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.06),
                    backgroundColor: const Color.fromRGBO(154, 197, 244, 1),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
