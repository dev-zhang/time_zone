import 'package:flutter/material.dart';
import 'dart:async';
import 'package:time_zone/time_zone.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TimeZone _timeZone;

  @override
  void initState() {
    super.initState();
    _getTimeZone();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('current time zone: $_timeZone \n'),
        ),
      ),
    );
  }

  Future<void> _getTimeZone() async {
    final timeZone = await TimeZone.currentZone();
    setState(() {
      _timeZone = timeZone;
    });
  }
}
