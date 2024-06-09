import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:katot_elektronik/screens/users/login_screen.dart';
import 'package:katot_elektronik/screens/users/register_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "İŞ TAKİP",
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(80))),
                width: 300,
                height: 200,
                margin: EdgeInsets.only(bottom: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "STOK TAKİP",
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              width: 300,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
