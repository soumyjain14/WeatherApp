import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp1());
}

var a;
var s;

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  var z;
  web(a) async {
    var url =
        'http://api.openweathermap.org/data/2.5/forecast?q=${a}&appid=3f9992990a15f8456ca590460b4c32c9';
    var response = await http.get(url);
    //print(response.body);
    var data = response.body;
    var jdata = jsonDecode(data);
    setState(() {
      var r = jdata['list'][0]['main']['temp'];
      s = jdata['list'][1]['weather'][0]['description'];
      var y = (r - 273.15).round();

      z = y.toString();
    });

    print(z + "°" + "C");
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.wb_sunny),
          elevation: 20,
          iconTheme: IconThemeData(color: Colors.yellow),
          title: Text('Weather App'),
          backgroundColor: Colors.purple.shade500,
          actions: [
            Icon(Icons.timer),
            
          ],
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.deepPurple.shade400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  style: TextStyle(fontSize: 30),
                  onChanged: (value) {
                    a = value;
                  },
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    labelText: 'Enter the city name',
                    labelStyle: TextStyle(color: Colors.yellow),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.orange,
                  child: Text(
                    'Click here for weather report',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    web(a);
                  },
                ),
                Text(
                  "Temperature is: " + z + "°" + "C" ??
                      "Waiting for the input city",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "Weather condition: " + s ?? "Waiting for the description",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
