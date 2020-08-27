import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp1());
}

var a;

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
      var y = (r - 273.15).round();

      z = y.toString();
    });

    print(z + "°" + "C");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          backgroundColor: Colors.blue.shade600,
        ),
        body: Center(
          child: Container(
            width: 500,
            height: 500,
            color: Colors.blue.shade400,
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
                    labelStyle: TextStyle(color: Colors.black),
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
                  child: Text(
                    'Click here for weather report',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    web(a);
                  },
                ),
                Text(z + "°" + "C" ?? "Waiting for the input city", style: TextStyle(fontSize: 30),),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
