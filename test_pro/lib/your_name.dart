import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/user_data.dart';

class YourName extends StatefulWidget {
  final String email;
  const YourName({Key? key, required this.email}) : super(key: key);

  @override
  State<YourName> createState() => _YourNameState();
}

class _YourNameState extends State<YourName> {
  String _name = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.2),
            Text(
              "Your Name?",
              style: TextStyle(
                  fontSize: height * 0.0013 * 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.1),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (val) {
                  if (val!.length < 2) {
                    return "Your name should be consist of at least 2 character";
                  } else {
                    return null;
                  }
                },
                onSaved: (name) {
                  _name = name!;
                },
                decoration: InputDecoration(hintText: 'Your Name'),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                bool _validate = _formKey.currentState!.validate();

                if (_validate) {
                  _formKey.currentState!.save();
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => UserData(
                                name: _name,
                                email: widget.email,
                              )));
                }
              },
              child: Text(
                "Continue",
                style: TextStyle(fontSize: height * 18 * 0.0013),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                minimumSize: Size(width * 0.93, height * 0.06),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
