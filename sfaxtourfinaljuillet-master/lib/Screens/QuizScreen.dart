import 'dart:async';
import 'dart:collection';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled1/Controller/BeaconController.dart';
import 'package:untitled1/Controller/Controller.dart';
import 'package:untitled1/Screens/loading_screen.dart';

import '../Screens/body.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  StreamSubscription<RangingResult>? _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  // final _beacons = <Beacon>[];
  var mybeacons = <String, Beacon>{};
  var tryy = <String, Beacon>{};
  String test_song="";
  final controller = Get.find<BeaconController>();

  @override
  void initState() {
    super.initState();
    initScanBeacon();
    //pauseScanBeacon();

    /* controller.startStream.listen((flag) {
      if (flag == true) {
        initScanBeacon();
      }
    });

    controller.pauseStream.listen((flag) {
      if (flag == true) {
        pauseScanBeacon();
      }
    });*/
  }
  checkAllRequirements() async {
    await flutterBeacon.requestAuthorization;

    final bluetoothState = await flutterBeacon.bluetoothState;
    controller.updateBluetoothState(bluetoothState);
    print('BLUETOOTH $bluetoothState');

    final authorizationStatus = await flutterBeacon.authorizationStatus;
    controller.updateAuthorizationStatus(authorizationStatus);
    print('AUTHORIZATION $authorizationStatus');

    final locationServiceEnabled =
    await flutterBeacon.checkLocationServicesIfEnabled;
    controller.updateLocationService(locationServiceEnabled);
    print('LOCATION SERVICE $locationServiceEnabled');

    if (controller.bluetoothEnabled &&
        controller.authorizationStatusOk &&
        controller.locationServiceEnabled) {
      print('STATE READY');
      print('SCANNING');

      controller.startScanning();

    } else {
      print('STATE NOT READY');
      controller.pauseScanning();
    }
  }
  initScanBeacon() async {
    // await Future.delayed(Duration(seconds: 10));

    var status = await Permission.bluetoothScan.request();
    var status2 = await Permission.bluetoothConnect.request();
    var status3= await Permission.bluetooth.request();

    print(status.isGranted);
    print(status2.isGranted);
    print(status3.isGranted);

    await flutterBeacon.initializeScanning;
    if (!controller.authorizationStatusOk ||
        !controller.locationServiceEnabled ||
        !controller.bluetoothEnabled) {
      print(
          'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
          'locationServiceEnabled=${controller.locationServiceEnabled}, '
          'bluetoothEnabled=${controller.bluetoothEnabled}');
      return;
    }

    final regions = <Region>[
      Region(
        identifier: 'iBeacon1',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF612',
      ),
      Region(
        identifier: 'iBeacon2',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF613',
      ),
      Region(
        identifier: 'iBeacon3',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF614',
      ),
      Region(
        identifier: 'iBeacon4',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF615',
      ),
      Region(
        identifier: 'iBeacon5',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF611',
      ),
      Region(
        identifier: 'iBeacon6',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF616',
      ),
      Region(
        identifier: 'iBeacon7',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF617',
      ),
      Region(
        identifier: 'iBeacon8',
        proximityUUID: 'EBEFD083-70A2-47C8-9837-E7B5634DF618',
      )
    ];

    if (_streamRanging != null) {
      if (_streamRanging!.isPaused) {
        _streamRanging?.resume();
        return;
      }
    }
    _streamRanging =

        flutterBeacon.ranging(regions).listen((RangingResult result) {
      // print('range result is' + result.toString());
      if (mounted) {
        // print("outside");
        // debugPrint("outsideeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

        setState(() {
          _regionBeacons[result.region] = result.beacons;
          // _beacons.clear();
          // _regionBeacons.values.forEach((list) {
          //   _beacons.addAll(list);
          // });
          // _beacons.sort(_compareParameters);
          // controller.setbeaconsList(_beacons);
          // controller.getClosest();


          if (result.beacons.isNotEmpty){
            mybeacons[result.beacons.first.proximityUUID]=result.beacons.first;}
          if(mybeacons.isNotEmpty){
            tryy = SplayTreeMap.from(
                mybeacons, (key1, key2) => mybeacons[key1]!.rssi.compareTo(mybeacons[key2]!.rssi));
            if(test_song !=tryy.values.toList()[tryy.length-1].proximityUUID){
              // FlutterRingtonePlayer.playNotification();
              FlutterRingtonePlayer.play(fromAsset: "assets/song/notification.mp3");
          test_song=tryy.values.toList()[tryy.length-1].proximityUUID;
          print(tryy.values.toList()[tryy.length-1].proximityUUID);
            }
          }
        });
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    // if (_beacons.isNotEmpty) {
    //   setState(() {
    //     _beacons.clear();
    //   });
    // }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamRanging != null) {
        if (_streamRanging!.isPaused) {
          _streamRanging?.resume();
          // _streamRanging?.resume();
        }
      }
      await checkAllRequirements();
    } else if (state == AppLifecycleState.paused) {
      _streamRanging?.pause();
      // _streamRanging?.pause();

    }
  }


  @override
  void dispose() {
    _streamRanging?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*print(_beacons);
    print(_beacons[0].proximity);*/
    QuestionController _controller = Get.put(QuestionController());
    return GetBuilder<BeaconController>(initState: (_) {
    }, builder: (_) {
      return Scaffold(
       /*   floatingActionButton: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
            /*  controller.setbeaconsList(_beacons);
              controller.getClosest();*/
            },
          ),*/
          // appBar: AppBar(
          // backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   actions: [
          //    FlatButton(
          //
          // onPressed: () {
          //   print(tryy.values.toList()[0].proximityUUID);
          // },
          // child: Text("skip",style: TextStyle(color: Colors.white),))
          //    ],
          //
          //  ),
          // body: controller.lastClosest.proximityUUID != null
          //     ? controller.lastClosest.proximityUUID == controller.closest.proximityUUID
          //         ? LoadingScreen()
          //         : Body(
          //             question: _controller.questions.singleWhere((element) =>
          //                 element.proximityUUID ==
          //                 controller.closest.proximityUUID),
          //           )
          //     : controller.closest.proximityUUID == null?LoadingScreen():
          // Body(
          //         question: _controller.questions.singleWhere((element) =>
          //             element.proximityUUID ==
          //             controller.closest.proximityUUID,orElse: () => _controller.questions[1]),
          //       )
          //

        body: tryy.length>0 ? tryy.values.toList()[tryy.length-1].proximityUUID.isEmpty ?LoadingScreen() :
      Body(
                  question: _controller.questions.singleWhere((element) =>
                      element.proximityUUID ==
                          tryy.values.toList()[tryy.length-1].proximityUUID),
                )

            :LoadingScreen()



          /*_beacons.isEmpty
              ? CircularProgressIndicator()
              :*/
          /*ListView(
        children: ListTile.divideTiles(
        context: context,
        tiles: _beacons.map(
        (beacon) {
      return*/
          /*Center(
                  child: ListTile(
                  title: Text(
                    controller.closest.proximityUUID.toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                  subtitle: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Distance: ${controller.closest.distance}',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        flex: 1,
                        fit: FlexFit.tight,
                      ),
                      Flexible(
                        child: Text(
                          'm\nRSSI: ${controller.closest.rssi}\nTXpower: ${controller.closest.txPower}',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        flex: 2,
                        fit: FlexFit.tight,
                      )
                    ],
                  ),
                ))*/
          //   })).toList(),)

          );
    });
  }
}
