// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var current;
  var humidity;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=Delhi&units=metric&appid=98c1c9301cf37b3078e52afbd352bd6c"));

    var results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['main'];
      current = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windspeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Weather App'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFfd8907),
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in Delhi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' : "Loading",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    current != null ? current.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.thermostat_outlined,
                        color: Colors.black,
                      ),
                      title: Text('Temperature',
                          style: TextStyle(color: Colors.black)),
                      trailing: Text(
                          temp != null ? temp.toString() + '\u00B0' : "Loading",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.cloud,
                        color: Colors.black,
                      ),
                      title: Text('Weather',
                          style: TextStyle(color: Colors.black)),
                      trailing: Text(
                          description != null
                              ? description.toString()
                              : "Loading",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.wb_sunny,
                        color: Colors.black,
                      ),
                      title: Text('Humidity',
                          style: TextStyle(color: Colors.black)),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.waves,
                        color: Colors.black,
                      ),
                      title: Text('Wind Speed',
                          style: TextStyle(color: Colors.black)),
                      trailing: Text(
                          windspeed != null ? windspeed.toString() : "Loading",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
