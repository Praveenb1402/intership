import 'dart:async';
import 'package:flutter/material.dart';


class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _countdownValue = 30; // Initial countdown value
  late Timer _timer; // Timer object
  bool _field = true;
  bool _visiblity=false;

  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownValue > 0) {
          _countdownValue--;
        } else {
          // Timer will be canceled once it reached 0
          _timer.cancel();
          _field=false;
          _visiblity=true;
        }
      });
    });
  }

  @override
  void dispose() {
    // For better measure destroy the timer
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Win Certificate'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30,right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tell me About Yourself.\n Note: Once the Box is touched timer will be started. You have 30 Seconds to answer',
                // Display the countdown value
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              TextField(minLines:5,
                maxLength: 200,
                enabled: _field,
                maxLines:10,onTap: () {
                startTimer();
              },keyboardType: TextInputType.text,
                decoration: const InputDecoration(

                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey))),),
              SizedBox(height: 20,),
              Text("$_countdownValue",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
              Visibility(visible: _visiblity,child: ElevatedButton(onPressed: (){}, child: Text("Submit")))
            ],
          ),
        ),
      ),
    );
  }
}