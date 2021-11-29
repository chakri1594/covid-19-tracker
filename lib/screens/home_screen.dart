import 'dart:convert';

import 'package:covid_19_tracker/Precaution/Precaution_page.dart';
import 'package:covid_19_tracker/constants.dart';
import 'package:covid_19_tracker/screens/search.dart';
import 'package:covid_19_tracker/selfassessment/qna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/screens/virus_details_page.dart';
import 'package:covid_19_tracker/Symptoms/Symptoms_page.dart';
import 'package:http/http.dart' as http;
import 'package:covid_19_tracker/screens/worldwidepanel.dart';

import 'countypage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<HomeScreen> {
  Map worldData;

  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://corona.lmao.ninja/v2/all'));
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://corona.lmao.ninja/v2/countries?sort=cases'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),

//wrap singlechildscrollview for correct displaying in small density devices
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Worldwide',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Regional',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            worldData == null
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  )
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    titled(),
                    SizedBox(height: 1),
                    buildPreventation(),
                    const SizedBox(height: 40),
                    buildHelpCard(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row titled() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Image.asset("assets/icons/symptoms.png"),
          iconSize: 100,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Symptoms(
                    color: Colors.green,
                    imgPath: "assets/symptoms/symptoms.png")));
            //VirusDetailsScreen();
          },
        ),
        IconButton(
          icon: Image.asset("assets/icons/use_mask.png"),
          iconSize: 100,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Precaution(
                    color: Colors.green,
                    imgPath: "assets/prevention/boy.png")));
            //VirusDetailsScreen();
          },
        ),
        IconButton(
          icon: Image.asset("assets/icons/faq.png"),
          iconSize: 100,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VirusDetailsScreen(
                    color: Colors.green,
                    imgPath: "assets/icons/corona_virus.png")));
            //VirusDetailsScreen();
          },
        ),

/*
         PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Use Masks",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use Masks",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Clean Disinfect",
        ),*/
      ],
    );
  }

  Row buildPreventation() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          PreventitonCard(
            title: "        Symptoms",
          ),
          PreventitonCard(
            title: "Precaution      ",
          ),
          PreventitonCard(
            title: "Info             ",
          ),
        ]);
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => QNA()));
            },
            child: Container(
              padding: EdgeInsets.only(
                // left side padding is 40% of total width
                left: MediaQuery.of(context).size.width * .4,
                top: 20,
                right: 20,
              ),
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF60BE93),
                    Color(0xFF1B8D59),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Self Assessment\n",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    TextSpan(
                      text:
                          "Follow the instructions to \nget recommendations on your health",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: const Icon(
        Icons.coronavirus_rounded,
        color: kPrimaryColor,
        size: 40,
      ),
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      centerTitle: true,
      title: const AutoSizeText(
        "COVID-19 Tracker",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Trajan Pro",
          color: Color(0xFF1B8D59),
          fontWeight: FontWeight.w600,
        ),
        minFontSize: 14,
        stepGranularity: 2,
        maxLines: 1,
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {
            showSearch(context: context, delegate: Search(countryData));
          },
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  //final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    // this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
