// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracker/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import 'details_screen.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      spacing: 20,
      //shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //crossAxisCount: 2, childAspectRatio: 2),
      children: <Widget>[
        InfoCard(
          title: "Confirmed Cases",
          iconColor: Color(0xFFFF8C00),
          effectedNum: worldData['cases'],
          //title: 'Confirmed Cases',
          //panelColor: Colors.red[100],
          //textColor: Colors.red,
          //count: worldData['cases'].toString(),
        ),
        InfoCard(
          title: "Active Cases",
          iconColor: Color(0xFFFF2D55),
          effectedNum: worldData['active'],
          press: () {},
          //title: 'Active Cases',
          //panelColor: Colors.blue[100],
          //textColor: Colors.blue[900],
          //count: worldData['active'].toString(),
        ),
        InfoCard(
          title: "Total Recovered",
          iconColor: Color(0xFF50E3C2),
          effectedNum: worldData['recovered'],
          press: () {},
          //title: 'Recovered Cases',
          //panelColor: Colors.green[100],
          //textColor: Colors.green,
          //count: worldData['recovered'].toString(),
        ),
        InfoCard(
            title: "Deceased Cases",
            iconColor: Color(0xFF5856D6),
            effectedNum: worldData['deaths'],
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsScreen();
              }));
            }
            //title: 'Deceased Cases',
            //panelColor: Colors.grey[400],
            //textColor: Colors.grey[900],
            //count: worldData['deaths'].toString(),
            ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String count;
  final int effectedNum;
  final double finalNum;
  final Color iconColor;
  final Function press;
  final Map worldData;

  const InfoCard(
      {Key key,
      this.worldData,
      this.title,
      this.effectedNum,
      this.iconColor,
      this.press,
      this.finalNum,
      this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            // Here constraints.maxWidth provide us the available width for the widget
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        // wrapped within an expanded widget to allow for small density device
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/running.svg",
                              height: 12,
                              width: 12,
                              color: iconColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: kTextColor),
                              children: [
                                TextSpan(
                                  text: "$effectedNum\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: "People",
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Expanded(
                          //child: LineReportChart(),
                        //),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
