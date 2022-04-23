import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_pro/home.dart';

String _gender = "";
int _age = 0;
int _height = 0;
int _weight = 0;

class UserData extends StatefulWidget {
  final name;
  final email;
  const UserData({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    pages.addAll([GenderPage(), AgePage(), HeightPage(), WeightPage()]);
    super.initState();
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
        title: Image.asset("data/images/logo.png"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
              itemCount: pages.length,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              _pageIndex++;
              if (_pageIndex >= 4) {
                FirebaseFirestore _instance = FirebaseFirestore.instance;

                CollectionReference col = _instance.collection('users');
                DocumentReference ref = col.doc(widget.email);
                await ref.update({
                  "name": widget.name,
                  "age": _age,
                  "height": _height,
                  "weight": _weight,
                  "gender": _gender,
                });

                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => HomePage()));
              }
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              "Next",
              style: TextStyle(fontSize: height * 18 * 0.0013),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue.shade900,
              minimumSize: Size(width * 0.93, height * 0.06),
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 4,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: height * 0.12),
          Text(
            "What is your sex?",
            style: TextStyle(
                fontSize: height * 0.0013 * 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: height * 0.25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = "Female";
                      });
                    },
                    child: Container(
                      height: height * 0.2,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2))
                        ],
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.female,
                        size: width * 0.25,
                        color: _gender == "Female" ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Woman",
                    style: TextStyle(
                        fontSize: height * 0.0013 * 16, color: Colors.grey),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = "Male";
                      });
                    },
                    child: Container(
                      height: height * 0.2,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 2))
                        ],
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.male,
                        size: width * 0.25,
                        color: _gender == "Male"
                            ? Colors.blue.shade900
                            : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Man",
                    style: TextStyle(
                        fontSize: height * 0.0013 * 16, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: height * 0.1),
        ],
      ),
    );
  }
}

class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: height * 0.12),
        Text(
          "How Old Are You?",
          style: TextStyle(
              fontSize: height * 0.0013 * 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.2),
        SizedBox(
          height: height * 0.35,
          child: CupertinoPicker(
              itemExtent: 64,
              looping: true,
              onSelectedItemChanged: (index) {
                _age = index + 1;
              },
              children: getAges()),
        ),
      ],
    );
  }

  List<Widget> getAges() {
    List<Widget> ages = [];
    for (int i = 1; i < 100; i++) {
      ages.add(Center(child: Text(i.toString())));
    }
    return ages;
  }
}

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: height * 0.12),
        Text(
          "How tall are you?",
          style: TextStyle(
              fontSize: height * 0.0013 * 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.2),
        SizedBox(
          height: height * 0.35,
          child: CupertinoPicker(
              itemExtent: 64,
              looping: true,
              onSelectedItemChanged: (index) {
                _height = index + 100;
              },
              children: getHeights()
                  .map(
                    (e) => Center(
                      child: Text(e.toString()),
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }

  List<int> getHeights() {
    List<int> heights = [];
    for (int i = 100; i < 251; i++) {
      heights.add(i);
    }
    return heights;
  }
}

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: height * 0.12),
        Text(
          "How much is your weight?",
          style: TextStyle(
              fontSize: height * 0.0013 * 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.2),
        SizedBox(
          height: height * 0.35,
          child: CupertinoPicker(
              itemExtent: 64,
              looping: true,
              onSelectedItemChanged: (index) {
                _weight = index + 40;
              },
              children: getWeights()
                  .map(
                    (e) => Center(
                      child: Text(e.toString()),
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }

  List<int> getWeights() {
    List<int> weights = [];
    for (int i = 40; i < 151; i++) {
      weights.add(i);
    }
    return weights;
  }
}
