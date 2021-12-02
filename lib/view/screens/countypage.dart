import 'package:covid_19_tracker/view/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {

    http.Response response =
    await http.get(Uri.parse ('https://corona.lmao.ninja/v2/countries'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search_rounded),onPressed: (){

          showSearch(context: context, delegate: Search(countryData));

          },)
        ],
        title: const Text('Country Statistics'),
        backgroundColor: Color(0xFF0D8E53),

      ),
      body: countryData == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          countryData[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold),

                        ),
                        Image.network(
                          countryData[index]['countryInfo']['flag'],
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'CONFIRMED:' +
                                  countryData[index]['cases'].toString(),
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,),
                            ),
                            Text(
                              'ACTIVE:' +
                                  countryData[index]['active'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              'RECOVERED:' +
                                  countryData[index]['recovered'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              'DEATHS:' +
                                  countryData[index]['deaths'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}
