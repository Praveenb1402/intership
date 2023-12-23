import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:untitled/main_page.dart';

class verification_page extends StatefulWidget {
  final String otp;

  const verification_page({super.key, required this.otp});

  @override
  State<verification_page> createState() => _verification_pageState();
}

class _verification_pageState extends State<verification_page> {
  String? otpmatch;

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
      body: SingleChildScrollView(
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
                      "Verification",
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
                margin: const EdgeInsets.only(top: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      "Enter the OTP sent to your Phone Number",
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      onSubmitted: (value) {
                        otpmatch = value;
                        setState(() {
                          otpmatch = value;
                        });
                      },
                      onCompleted: (value) {
                        otpmatch = value;
                        setState(() {
                          otpmatch = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (otpmatch != null) {
                            verify(context, otpmatch.toString().trim(),
                                widget.otp);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection: DismissDirection.none,
                                    elevation: 5,
                                    shape: BeveledRectangleBorder(),
                                    content: Text("Wrong Otp")));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        child: const Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(height: 30),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't receive any code"),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Resend New Code",
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

void verify(BuildContext context, String otpmatch, otp) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  try {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: otp, smsCode: otpmatch);
    var userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user!=null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => main_page()));
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        elevation: 5,
        shape: BeveledRectangleBorder(),
        content: Text("Wrong Otp")));
  }
}
