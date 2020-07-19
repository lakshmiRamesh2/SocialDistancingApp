import 'package:flutter/material.dart';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_blue/flutter_blue.dart';
//import 'package:bluetooth/bluetooth.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_beacon/flutter_beacon.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  static const UUID = '39ED98FF-2900-441A-802F-9C398FC199D2';
  static const MAJOR_ID = 1;
  static const MINOR_ID = 100;
  static const TRANSMISSION_POWER = -59;
  static const IDENTIFIER = 'com.example.myDeviceRegion';
  static const LAYOUT = BeaconBroadcast.ALTBEACON_LAYOUT;
  static const MANUFACTURER_ID = 0x0118;

  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  BeaconStatus _isTransmissionSupported;
  bool _isAdvertising = false;
  StreamSubscription<bool> _isAdvertisingSubscription;

  @override
  void initState() {
    super.initState();
    beaconBroadcast.checkTransmissionSupported().then((isTransmissionSupported) {
      setState(() {
        _isTransmissionSupported = isTransmissionSupported;
        print(_isTransmissionSupported);
      });
    });

    _isAdvertisingSubscription =
        beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
          setState(() {
            _isAdvertising = isAdvertising;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Beacon Broadcast'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 16.0),

                (_isAdvertising)?Text('Beacon started Advertising', style: Theme.of(context).textTheme.headline):
                Text('Please click on start to Beacon Advertising', style: Theme.of(context).textTheme.headline),
                Container(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.lightGreen,
                      onPressed: () {
                        beaconBroadcast
                            .setUUID(UUID)
                            .setMajorId(MAJOR_ID)
                            .setMinorId(MINOR_ID)
                            .setTransmissionPower(-59)
                            .setIdentifier(IDENTIFIER)
                            .setLayout(LAYOUT)
                            .setManufacturerId(MANUFACTURER_ID)
                            .start();
                      },
                      child: Text('START',style: TextStyle(color: Colors.white),),
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        beaconBroadcast.stop();
                      },
                      child: Text('STOP',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: Colors.black,),
                ),
                Text('Beacon Data', style: Theme.of(context).textTheme.headline),
                Text('UUID: $UUID'),
                Text('Major id: $MAJOR_ID'),
                Text('Minor id: $MINOR_ID'),
                Text('Tx Power: $TRANSMISSION_POWER'),
                Text('Identifier: $IDENTIFIER'),
                Text('Layout: $LAYOUT'),
                Text('Manufacturer Id: $MANUFACTURER_ID'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: Colors.black,),
                ),
                Text('Becon Transmission Status',
                    style: Theme.of(context).textTheme.headline),
                Text('$_isTransmissionSupported',
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          ),
        ),

    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_isAdvertisingSubscription != null) {
      _isAdvertisingSubscription.cancel();
    }
  }









}
