import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/settings.dart';
import './video_call.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ClientRole _role = ClientRole.Broadcaster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Video Call'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole? value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole? value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: onJoin,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          'Join',
                            style: TextStyle(color: Colors.white,)
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {

    if (channelName.isNotEmpty) {
      await [Permission.microphone, Permission.camera].request();

      // await _handleCameraAndMic(Permission.camera);
      // await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCall(
            channelName: channelName,
            role: _role,
            key: const Key('key'),
          ),
        ),
      );
    }
  }

}
