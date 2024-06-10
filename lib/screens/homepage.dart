import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Card1",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 150,
                  height: 150,
                ),
                SizedBox(width: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Card2",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Card3",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 150,
                  height: 150,
                ),
                SizedBox(width: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Card4",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
