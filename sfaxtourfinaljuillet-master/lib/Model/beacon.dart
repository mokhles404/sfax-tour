

import 'package:flutter_beacon/flutter_beacon.dart';

class Beacon{



  String? proximityUUID;
  Proximity? proximity;
  int? rssi;
  int? txPower;
 double? distance;



  Beacon(
      {this.proximityUUID,
      this.proximity,
      this.rssi,
      this.txPower,
      this.distance});

  Beacon.fromMap(Map<String, dynamic> data) {

    proximityUUID =  data["proximityUUID"] as String ;
    proximity=data["proximity"] as Proximity ;
    rssi=data["rssi"] as int ;
    txPower=data["txPower"] as int ;

    distance=data["distance"] as double ;
  }
  }

