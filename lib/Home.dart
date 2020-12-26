import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _price = "0";

  void _getPrice() async {

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode( response.body );
    setState(() {
      _price = retorno["BRL"]["buy"].toString();
    });

    print("Result : " + retorno["BRL"]["buy"].toString() );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _price,
                  style: TextStyle(
                    fontSize: 35
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                    "Refresh",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: _getPrice,
              )
            ],
          ),
        ),
      ),
    );
  }
}
