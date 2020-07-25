import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String url = 'https://jsonplaceholder.typicode.com/posts';

  String output;

  Future<String> makePOSTRequest() async {
    // make a post request to the api and store the response
    String input = '{"title": "Hello", "body": "body text", "userId": 1}';
    http.Response response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: input,
    );
    if (response.statusCode == 201) {
      var data = response.body;
//      dynamic decodedData = jsonDecode(data);
      return data;
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
            RaisedButton(
              onPressed: () async {
                output = await makePOSTRequest();
                setState(() {});
              },
              elevation: 7.0,
              child: Text(
                'Make POST Request',
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
                  (output == null) ? 'Waiting...' : output,
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
