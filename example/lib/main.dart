import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_hidden_drawer/animated_hidden_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Platform messages are asynchronous, so we initialize in an async method.
  Widget selectedWidget = Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
      height: 665,
      width: 1000,
      child: Center(
        child: Text("hello, this is my first plugin"),
      ));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: HiddenDrawer(
        duration: Duration(milliseconds: 500),
        items: [
          GestureDetector(
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  color: Color(0xff6b705c),
                  size: 35,
                ),
                Text(
                  " Home",
                  style: TextStyle(
                      color: Color(0xff6b705c),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                selectedWidget = Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Color(0xffffe8d6)),
                    height: 979,
                    width: 1000,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/home.png"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "W E L C O M E",
                            style: TextStyle(
                                color: Color(0xff6b705c),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ));
              });
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Color(0xff6b705c),
                  size: 35,
                ),
                Text(
                  " About",
                  style: TextStyle(
                      color: Color(0xff6b705c),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                selectedWidget = Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Color(0xffffe8d6)),
                    height: 979,
                    width: 1000,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/about us.png"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Github : krish-dev-7\n"
                            "Instagram: krish_krush",
                            style: TextStyle(
                                color: Color(0xff6b705c),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ));
              });
            },
          ),
        ],
        child: selectedWidget,
        backgroundColor: Color(0xffffe8d6),
        drawerBackgroundColor: Color(0xffb7b7a4),
        borderRadius: 80,
        header: Container(
          height: 250,
          width: 1000,
          color: Color(0xff6b705c),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffffe8d6),
                  radius: 40,
                  child: Icon(
                    Icons.account_circle,
                    color: Color(0xff6b705c),
                    size: 80,
                  ),
                ),
                Text(
                  "krishna",
                  style: TextStyle(
                      color: Color(0xffffe8d6),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        x: 250,
        y: 200,
        scale: 0.7,
      )),
    );
  }
}
