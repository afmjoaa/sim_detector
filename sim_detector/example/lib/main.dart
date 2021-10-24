import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';

import 'package:sim_detector/sim_detector_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription<dynamic>? SimSubscriptionIdStreamSubscription;
  String lastSubscriptionId = '';

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  void dispose() {
    SimSubscriptionIdStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    await [
      Permission.phone
    ].request();
  }

  void _addSimSubscriptionChangeListener() async {
    if(Platform.isAndroid) {
      addSimSubscriptionChangeHandler().then((_) {
        listenForSimSubscriptionIdChange();
      });
    }
  }

  void _removeSimSubscriptionChangeListener() {
    if(Platform.isAndroid) {
      SimSubscriptionIdStreamSubscription?.cancel();
      removeSimSubscriptionChangeHandler();
    }
  }

  void _showSnackBar(String msg, BuildContext context){
    final snackBar = SnackBar(content: Text(msg),);
    _messengerKey.currentState?.showSnackBar(snackBar);
  }

  void listenForSimSubscriptionIdChange() {
    SimSubscriptionIdStreamSubscription = simSubscriptionChangeStream?.listen((params) {
      print('Current Subscription ID: $params');
      setState(() {
        lastSubscriptionId = params.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sim detector'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.blue,
                ),
                onPressed:(){
                  _addSimSubscriptionChangeListener();
                  _showSnackBar('Added SimSubscriptionChangeListener', context);
                } ,
                child: const Text('Add Sim Subscription Handler', style: const TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.blue,
                ),
                onPressed: (){
                  _removeSimSubscriptionChangeListener();
                  _showSnackBar('Removed SimSubscriptionChangeListener', context);
                },
                child: const Text('Remove Sim Subscription Handler' , style: const TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              Text("Last subscriptionId = $lastSubscriptionId")
            ],
          ),
        ),
      ),
    );
  }
}
