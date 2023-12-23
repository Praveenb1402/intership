import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:icons_flutter/icons_flutter.dart";
import "package:provider/provider.dart";
import "package:untitled/signin.dart";
import "package:untitled/signup_page.dart";
import "package:untitled/verification_page.dart";

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final email_controler = TextEditingController();

  bool _isloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Stack(
            children: [

              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 80,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.only(top: 170),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Enter your Phone Number to login into your Account",
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: email_controler,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Phone Number with STD code",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _isloading = true;
                          if (email_controler.text
                              .trim()
                              .length == 13) {
                            signin(context, email_controler.text.trim(),
                                _isloading!);
                          } else {
                            _isloading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection: DismissDirection.none,
                                    elevation: 5,
                                    shape: BeveledRectangleBorder(),
                                    content: Text("Invalid Phone Number")));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const Text("OR"),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<Googolesigin>(
                            context, listen: false);
                        provider.signInWithGoogle(context, _isloading!);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo, onPrimary: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FlutterIcons.google_ant),
                          Text("Login using Google"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Don't have an Account ? "),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const signup_page()));
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(color: Colors.indigo),
                          )),
                    ])
                  ],
                ),
              ),
              Center(
                  child: _isloading ? CircularProgressIndicator() : Text("")
              ),

            ],
          ),
        ),
      ),
    );
  }
}

void signin(BuildContext context, String phonenumber, bool _isloading) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  try {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (otp, froceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => verification_page(otp: otp)));
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {});
    _isloading = false;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        elevation: 5,
        shape: BeveledRectangleBorder(),
        content: Text("Invalid Phone Number")));
    _isloading = false;
  }
}



