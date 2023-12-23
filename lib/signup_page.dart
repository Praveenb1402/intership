import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/verification_page.dart';

class signup_page extends StatefulWidget {
  const signup_page({super.key});

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final password_controler = TextEditingController();
  final email_controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 30,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Registration",
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
                margin: const EdgeInsets.only(top: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      "Enter your Phone Number for Registration.\n We'll send you a verification code",
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: email_controler,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (email_controler.text.trim().length == 10) {
                            signin(context, email_controler.text.trim());
                          } else {
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
                          "Register",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(height: 30),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already have an Account ? "),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.indigo),
                          )),
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void signin(BuildContext context, String phonenumber) async {
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
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        elevation: 5,
        shape: BeveledRectangleBorder(),
        content: Text("Invalid Phone Number")));
  }
}
