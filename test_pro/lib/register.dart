import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/user_data.dart';
import 'package:test_pro/your_name.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool _isSignInFailed = false;

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isSignUpSelected = true;
  PageController _pageController = PageController(initialPage: 0);

  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    pages.addAll([PageSignUp(), PageSignIn()]);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Color.fromARGB(255, 5, 55, 95).withOpacity(0.4),
              width: width * 0.93,
              height: height * 0.07,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isSignUpSelected = true;
                          _pageController.jumpToPage(0);
                        });
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 16 * 0.0013,
                            color: isSignUpSelected
                                ? Colors.black
                                : Colors.white.withOpacity(0.6)),
                      ),
                      style: OutlinedButton.styleFrom(
                          minimumSize: Size(width * 0.45, height * 0.06),
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: isSignUpSelected
                              ? Colors.white
                              : Colors.transparent,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isSignUpSelected = false;
                          _pageController.jumpToPage(1);
                        });
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 16 * 0.0013,
                            color: isSignUpSelected
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size(width * 0.45, height * 0.06),
                        backgroundColor: isSignUpSelected
                            ? Colors.transparent
                            : Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            child: PageView(
              children: pages,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

class PageSignIn extends StatefulWidget {
  PageSignIn({Key? key}) : super(key: key);

  @override
  State<PageSignIn> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignIn> {
  Icon _hideIcon = Icon(
    Icons.remove_red_eye,
    color: Colors.black,
    size: 18,
  );
  bool _isHidden = true;
  String _email = "";
  String _password = "";
  final _signInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 30),
          Form(
            key: _signInKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _email = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        obscureText: _isHidden,
                        onSaved: (value) {
                          _password = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                                _hideIcon = _isHidden
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      );
                              });
                            },
                            icon: _hideIcon,
                            splashRadius: 10,
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.underline),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              bool _validate = _signInKey.currentState!.validate();

              if (_validate) {
                _signInKey.currentState!.save();
                print(_email);
                signingWithEmailAndPassword(_email, _password);
              } // check if user has agreed on policy and gave the permission
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
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Future<void> signingWithEmailAndPassword(
      String email, String password) async {
    try {
      // check if there is no user signed in
      if (_auth.currentUser == null) {
        User? signedInUser = (await _auth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;
        // check if signed in user is email verified if not then sign them out
        if (!signedInUser!.emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Email is not verified'),
            backgroundColor: Colors.red,
          ));
          _isSignInFailed = true;
          _auth.signOut();
        } else {
          print("user has signed in with email : ${signedInUser.email} ");
          FirebaseFirestore _instance = FirebaseFirestore.instance;

          CollectionReference col = _instance.collection('users');
          DocumentSnapshot snapshot = await col.doc(email).get();
          var data = snapshot.data() as Map;
          if (data['age'] == 0) {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => YourName(email: _email)));
          } else {
            //Navigator.push(context, main page);
          }
        }
      } else {
        // if user is already signed in then sign them out
        _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      _isSignInFailed = true;

      print("**********SIGN IN ERROR***************");
      if (e.code == 'user-not-found') {
        print("User not found");

        _isSignInFailed = true;

        _auth.signOut();
      } else if (e.code == 'wrong-password') {
        print("Wrong password");

        _isSignInFailed = true;

        _auth.signOut();
      } else {
        print(e);
      }
    }
  }
}

class PageSignUp extends StatefulWidget {
  PageSignUp({Key? key}) : super(key: key);

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isRHidden = true;
  Icon _hideRIcon = Icon(
    Icons.remove_red_eye,
    color: Colors.black,
    size: 18,
  );
  Icon _hideIcon = Icon(
    Icons.remove_red_eye,
    color: Colors.black,
    size: 18,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 30),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                    ),
                    Container(
                      height: height * 0.08,
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        validator: (email) {
                          if (!EmailValidator.validate(email!)) {
                            return 'Please enter a valid email.';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _email = value!;
                          print('email: ' + _email);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Password",
                    ),
                    Container(
                      height: height * 0.08,
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        obscureText: _isHidden,
                        validator: (pass) {
                          if (pass!.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value!;
                          print('password: ' + _password);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                                _hideIcon = _isHidden
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      );
                              });
                            },
                            icon: _hideIcon,
                            splashRadius: 10,
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Re-Write Password",
                    ),
                    Container(
                      height: height * 0.08,
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        onSaved: (value) {
                          _confirmPassword = value!;
                          print('password: ' + _confirmPassword);
                        },
                        obscureText: _isRHidden,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isRHidden = !_isRHidden;
                                _hideRIcon = _isRHidden
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      );
                              });
                            },
                            icon: _hideRIcon,
                            splashRadius: 10,
                          ),
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Wrap(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Terms of Use ',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  bool _validate = _formKey.currentState!.validate();

                  if (_validate) {
                    _formKey.currentState!.save();

                    if (_password != _confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Passwords doesn\'t match'),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      addUserDocumentToFireStore(email: _email);
                      createAccount(_email, _password);
                    }
                  }

                  // check if user has agreed on policy and gave the permission
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
              SizedBox(height: height * 0.05)
            ],
          ),
        ],
      ),
    );
  }

  void createAccount(String email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        // Check if user exists or not
        if (_auth.currentUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Verification email has been sent'),
            backgroundColor: Colors.green,
          ));
          await _auth.signOut();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void addUserDocumentToFireStore({
    String name = "",
    String email = "",
    String gender = "",
    String height = "",
    String weight = "",
    int age = 0,
  }) {
    Map<String, dynamic> userData = Map();
    userData['name'] = name;
    userData['email'] = email;
    userData['gender'] = gender;
    userData['age'] = age;
    userData['height'] = height;
    userData['weight'] = weight;

    _firestore
        .collection("users")
        .doc(email)
        .set(userData)
        .then((v) => print("User data is added to firestore"));
  }
}
