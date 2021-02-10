import 'package:flutter/material.dart';
import 'package:gropare/constants.dart';
import 'package:gropare/models/splash.dart';
import 'package:gropare/screens/HomeScreen/components/HomeBody/homebody.dart';
import 'package:gropare/screens/HomeScreen/homescreen.dart';

class OnBoard extends StatefulWidget {
  final PageController pageController = PageController();

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: PageView.builder(
                  controller: widget.pageController,
                  itemCount: splashdata.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentindex = value;
                    });
                  },
                  itemBuilder: (context, i) {
                    return Page(
                      name: splashdata[i].name,
                      image: splashdata[i].image,
                      desc: splashdata[i].desc,
                    );
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: List.generate(
                                splashdata.length, (index) => buildDot(index))),
                        currentindex <= splashdata.length - 2
                            ? FlatButton(
                                onPressed: () {
                                  setState(() {
                                    currentindex++;
                                    widget.pageController
                                        .jumpToPage(currentindex);
                                  });
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ))
                            : nextButton()
                      ],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentindex == index ? kPrimaryColor : Colors.black38,
          borderRadius: BorderRadius.circular(50)),
    );
  }

  Widget nextButton() {
    return FlatButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Text(
              "Get Started",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}

class Page extends StatelessWidget {
  const Page({
    Key key,
    this.image,
    this.desc,
    this.name,
  }) : super(key: key);
  final String image, desc, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Image.network(
          image,
          fit: BoxFit.cover,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          desc,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
