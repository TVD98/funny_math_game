import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:funny_math_game/game/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final myControllerUser = TextEditingController();
  final myControllerPass = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUser.dispose();
    myControllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: myControllerUser,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ), TextField(
              controller: myControllerPass,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextButton(
              child: const Text('Bắt đầu'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.blue)))),
              onPressed: () {
                bool emptyLogin = messAlert(myControllerUser.text, myControllerPass.text);
                bool loginSuccess = checkLogin(myControllerUser.text, myControllerPass.text);
                if( emptyLogin){
                  if(loginSuccess) {
                    gotoGamePage();
                  } else {
                    showAlert();
                  }
                }else{
                  showAlert();
                }



              },
            ),
          ])),
    );
  }

  bool messAlert(String username, String password ){
    if(username=="" && password==""){
      showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            content: Text("Please enter your username and your password"),
          );
        },
      );
    }
    return checkLogin(username, password);
  }

  bool checkLogin(String username, String password) {
    return username == "midori" && password == "1234";
  }

  void showAlert() {
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            content: Text("Wrong! Please enter your account"),
          );
        },
    );
  }

  void gotoGamePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GamePage()),
    );
  }
}
