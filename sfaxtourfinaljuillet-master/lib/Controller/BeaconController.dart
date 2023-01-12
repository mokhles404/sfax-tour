
import 'dart:async';
import 'dart:math';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'package:untitled1/Model/beacon.dart' as beac;

class BeaconController extends GetxController {
  var bluetoothState = BluetoothState.stateOff.obs;
  var authorizationStatus = AuthorizationStatus.notDetermined.obs;
  var locationService = false.obs;
  var _startBroadcasting = false.obs;
  var _startScanning = false.obs;
  var _pauseScanning = false.obs;
  // StreamSubscription<RangingResult>? _streamRanging;
  // final _regionBeacons = <Region, List<Beacon>>{};
  List<Beacon> beacons = <Beacon>[];
  List<beac.Beacon> immbeacons = <beac.Beacon>[];
  List<beac.Beacon> nearbeacons = <beac.Beacon>[];
  late beac.Beacon closest=beac.Beacon();
  beac.Beacon lastClosest= beac.Beacon();
  List<beac.Beacon> ourBeacons=<beac.Beacon>[];
  bool get bluetoothEnabled => bluetoothState.value == BluetoothState.stateOn;
  bool get authorizationStatusOk =>
      authorizationStatus.value == AuthorizationStatus.allowed ||
          authorizationStatus.value == AuthorizationStatus.always;
  bool get locationServiceEnabled => locationService.value;




  void setLastclosest(beac.Beacon cl){
    lastClosest=cl;
    update();

  }
  void setbeaconsList(List<Beacon> temp){
    beacons=temp;
    for(var i in beacons){
      var distance=distanceCalculation(i.rssi, i.txPower);
      ourBeacons.add(beac.Beacon(distance: distance,proximityUUID: i.proximityUUID,proximity: i.proximity,rssi: i.rssi,txPower: i.txPower));
    }

    immbeacons=ourBeacons.where((element) => element.proximity==Proximity.immediate).toList();
    // print(immbeacons.length);
    nearbeacons=ourBeacons.where((element) => element.proximity==Proximity.near).toList();
    // print(nearbeacons.length);
  }


//   }

  dynamic minAccuracy(List<beac.Beacon> tempBeacons){
    // Declaring and assigning the
    // largestAccuracyValue and smallestAccuracyValue
    dynamic largestAccuracyValue = 0;
    dynamic smallestAccuracyValue = 0;

    for (var i = 0; i < tempBeacons.length; i++) {

      // Checking for largest value in the list
      if (tempBeacons[i].distance! > tempBeacons[largestAccuracyValue].distance!) {
        largestAccuracyValue =i;
      }

      // Checking for smallest value in the list
      if (tempBeacons[i].distance! < tempBeacons[smallestAccuracyValue].distance!) {
        smallestAccuracyValue = i;
      }
    }

    return smallestAccuracyValue;


    // Printing the values
    // print("Smallest value in the list : $smallestAccuracyValue");
    // print("Largest value in the list : $largestAccuracyValue");
  }
  dynamic distanceCalculation(rssiValue,txPowerValue) {

    //var txPowerValue = -62; // Normal ranges between -59 to -65

    if ( rssiValue == 0) {

      return -1.0;

    }

    var ratio = rssiValue*1.0/txPowerValue;

    if (ratio < 1.0) {

      return pow(ratio,10);

    }

    else {

      var distance = (0.89976)*pow(ratio,7.7095) + 0.111;

      return distance;

    }}
  void getClosest(){
 //   closest=ourBeacons[0];
    var index=minAccuracy(ourBeacons);

   // lastClosest=closest;
   //
   //  if (closest !=ourBeacons[index]){
   //    FlutterRingtonePlayer.playNotification();
   //
   //  }
    closest=ourBeacons[index];

   /* if(immbeacons.length>1){
      //TODO CALCULATE DISTANCE FOR IMMEDIATE BEACONS
      print("beacon is immediate akthr mn 1");

      var index=minAccuracy(ourBeacons);
      lastClosest=closest;
      closest=ourBeacons[index];
    }
    else
      if(immbeacons.length==1){
        //TODO TAKE ONE IMMEDIATE BEACON
        print("beacon is immediate 1");
        lastClosest=closest;
        closest=immbeacons[0];

      }
      else
        if(nearbeacons.length>1){
          //TODO CALCULATE DISTANCE FOR NEAR BEACONS
          print("beacon is near akthr mn 1");

          var index=minAccuracy(ourBeacons);
          lastClosest=closest;
          closest=ourBeacons[index];
        }
        else
          if(nearbeacons.length==1){
            print("beacon is near 1");

            //TODO TAKE ONE NEAR BEACON
            lastClosest=closest;
            closest=nearbeacons[0];
          }
          else {
            //TODO CALCULATE DISTANCE FOR FAR BEACONS
            print("beacon is far");
            var index=minAccuracy(ourBeacons);
            lastClosest=closest;
            closest=ourBeacons[index];
          }*/
/*    print("lastclosest is"+lastClosest.proximityUUID.toString());
    print("closest is"+closest.proximityUUID.toString());*/
          update();
  }
  updateBluetoothState(BluetoothState state) {
    bluetoothState.value = state;
  }
  updateAuthorizationStatus(AuthorizationStatus status) {
    authorizationStatus.value = status;
  }

  updateLocationService(bool flag) {
    locationService.value = flag;
  }

  startBroadcasting() {
    _startBroadcasting.value = true;
  }

  stopBroadcasting() {
    _startBroadcasting.value = false;
  }

  startScanning() {

    _startScanning.value = true;
    _pauseScanning.value = false;
  }

  pauseScanning() {
    _startScanning.value = false;
    _pauseScanning.value = true;
  }

  Stream<bool> get startBroadcastStream {
    return _startBroadcasting.stream;
  }

  Stream<bool> get startStream {
    return _startScanning.stream;
  }

  Stream<bool> get pauseStream {
    return _pauseScanning.stream;
  }
}