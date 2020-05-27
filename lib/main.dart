import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpdemo/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'http demo request',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'http://www.demourl.com';
  TextEditingController macIdHolder = TextEditingController();

  String room;
  String macIdFromInput;

  Future<String> getDataFromServer(String macId) async {
    // make a post request to the api and store the response
    http.Response response = await http.post(url, body: {'mac_id': macId});
    if (response.statusCode == 200) {
      var data = response.body;
      dynamic decodedData = jsonDecode(data);
      // replace query_key with the key of the json output by the api
      return decodedData['query_key'];
    } else {
      print(
          'Could not fetch data from api | Error Code: ${response.statusCode}');
      return 'Unable to Fetch Data';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo HTTP Request'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: macIdHolder,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration,
              onChanged: (value) {
                // we take the input in the textfield and store it in a variable macIdFromInput
                macIdFromInput = value;
              },
            ),
            RaisedButton(
              onPressed: () {
                setState(() async {
                  // we make request to the api using the macIdFromInput and store the output to the variable room
                  room = await getDataFromServer(macIdFromInput);
                  macIdHolder
                      .clear(); // clear the textfield after clicking on button
                });
              },
              elevation: 7.0,
              child: Text(
                'Get Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.teal[400],
            ),
            SizedBox(height: 50.0),
            Card(
              elevation: 3.0,
              child: Center(
                child: Text(
                  // if the room variable is null return waiting... else return the value of room
                  (room == null) ? 'Waiting...' : room,
                  style: TextStyle(
                    fontSize: 27.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
