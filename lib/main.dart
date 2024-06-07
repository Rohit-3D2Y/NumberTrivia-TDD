// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Joke(),
    );
  }
}

class Joke extends StatefulWidget {
  @override
  State<Joke> createState() => _JokeState();
}

class _JokeState extends State<Joke> {
  String _joke = '';
  final List<String> _jokes = [];

  Future<void> getJoke() async {
    http.Response response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/jokes/random'));
    Map data = jsonDecode(response.body);
    setState(() {
      _joke = data['setup'] + '...' + data['punchline'];
    });
  }

  void delJoke() {
    setState(() {
      _joke = '';
    });
  }

  void saveJoke() {
    setState(() {
      _jokes.add(_joke);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          'Joke Generator using API',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('This is a random Joke Generator'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        getJoke();
                      },
                      child: Text('Get Joke'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        saveJoke();
                      },
                      child: Text('Save Joke'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        delJoke();
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(_joke),
                ),
                SizedBox(height: 20.0),
                Text('Saved Jokes:'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _jokes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_jokes[index]),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
