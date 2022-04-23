import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue.shade900,
          ),
          splashRadius: 1,
        ),
        title: Image.asset("data/images/logo.png"),
        centerTitle: true,
      ),
      body: Center(child: Text("Main Page")),
    );
  }
}
