import 'package:flutter/material.dart';
import 'package:untitled/certificate.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  final List<Widget> _children = [
    certificate(),
    profile(),
    chat(),
  ];
  int _bottomnavigation_index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chitto Tech"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _bottomnavigation_index,
        onTap: (index) {
          setState(() {
            _bottomnavigation_index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.pages), label: "Certificate"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
              ),
              label: "Chat"),
        ],
      ),
      body: _children[_bottomnavigation_index],
    );
  }
}

class certificate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Certificate Screen'),
    );
  }
}

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: Container(
        width: 500,
        height: 400,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.indigo),
      )),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Profile Page",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CountdownScreen()));
              },
              child: Text("Win Certificate"),
            ),
          ],
        ),
      ),
    ]);
  }
}

class chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chat Screen'),
    );
  }
}
