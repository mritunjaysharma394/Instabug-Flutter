import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:instabug_flutter/instabug_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isIOS) {
        InstabugFlutter.start('068ba9a8c3615035e163dc5f829c73be', [InvocationEvent.floatingButton, InvocationEvent.shake]);
      }
      InstabugFlutter.showWelcomeMessageWithMode(WelcomeMessageMode.beta);
      InstabugFlutter.identifyUserWithEmail("aezz@instabug.com", "Aly Ezz");
      InstabugFlutter.logInfo("Test Log Info Message from Flutter!");
      InstabugFlutter.logDebug("Test Debug Message from Flutter!");
      InstabugFlutter.logVerbose("Test Verbose Message from Flutter!");
      InstabugFlutter.logOut();
      InstabugFlutter.setLocale(Locale.German);
      InstabugFlutter.setColorTheme(ColorTheme.dark);
      InstabugFlutter.appendTags(['tag1', 'tag2']);
      
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void resetTags() {
    InstabugFlutter.resetTags();
  }

  void getTags() async {
    List<String> tags = await InstabugFlutter.getTags();
    print(tags.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              RaisedButton(onPressed: resetTags, child: Text('reset tags'), color: Colors.lightBlue),
              RaisedButton(onPressed: getTags, child: Text('get tags'), color: Colors.lightBlue)
            ],
          )
        ),
      ),
    );
  }

}
