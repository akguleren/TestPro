import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "data/images/logo.png",
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Text(
                  "Test Pro is a mobile application to help you reach your best form while you stay healthy",
                  style: TextStyle(
                    fontSize: height * 24 * 0.0013,
                    fontFamily: 'Akshar',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  "Continue with e-mail",
                  style: TextStyle(fontSize: height * 18 * 0.0013),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(width * 0.93, height * 0.06)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.03),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Continue without sign-up",
                style: TextStyle(
                    color: Colors.blue, fontSize: height * 0.0013 * 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  
}
