import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:untitled1/constants/firebase.dart';
import 'package:untitled1/page/app_localizations.dart';
import 'package:untitled1/provider/local_provider.dart';

import 'Controller/BeaconController.dart';
import 'Controller/Controller.dart';
import 'Controller/language_controller.dart';

import 'Screens/selectLangueScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await flutterBeacon.requestAuthorization;
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  await initialization.then((value){

    Get.put(QuestionController());
     Get.put(BeaconController());

  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState()=>MyAppState();
}
class MyAppState extends State<MyApp>{
  final controller = Get.find<BeaconController>();
  StreamSubscription<BluetoothState>? _streamBluetooth;
  int currentIndex = 0;
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    listeningState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if( result== ConnectivityResult.none){
        Get.defaultDialog(
          title: "Connexion est désactivée",
          content: Text("votre connexion est désactivée veuillez l'activer")
        );
      }
    });

  }


  listeningState() async {
    print('Listening to bluetooth state');

    var status = await Permission.bluetoothScan.request();
    var status2 = await Permission.bluetoothConnect.request();
    var status3= await Permission.bluetooth.request();

    print(status.isGranted);
    print(status2.isGranted);
    print("*********");
    print(status3.isGranted);
    print("*********");
    await flutterBeacon.initializeScanning;
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      controller.updateBluetoothState(state);
      // Get.dialog(dialogalert(title: 'blootouth diasable', content: '',));

      await checkAllRequirements(state: state);
    });
  }

  checkAllRequirements({BluetoothState? state}) async {
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
    // print("location !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "+locationServiceEnabled.toString());
    // print("blotouth !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "+bluetoothState.toString());
    print(controller.bluetoothEnabled &&
        controller.authorizationStatusOk &&
        controller.locationServiceEnabled);
    if (controller.bluetoothEnabled &&
        controller.authorizationStatusOk &&
        controller.locationServiceEnabled) {
      print("*******************************************");
      print('STATE READY');
      if (currentIndex == 0) {
        print('SCANNING');
        controller.startScanning();
      } else {
        print('BROADCASTING');
        controller.startBroadcasting();
      }
    } else {
      print('STATE NOT READY');
      controller.pauseScanning();
      if(state == BluetoothState.stateOff){

      await handleOpenBluetooth();
      }
      if(!controller.locationServiceEnabled){

        await handleOpenLocationSettings();
      }

      // await handleOpenLocationSettings();


    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null) {
        if (_streamBluetooth!.isPaused) {
          _streamBluetooth?.resume();
        }
      }
      await checkAllRequirements();
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    _streamBluetooth?.cancel();
    subscription.cancel();
    super.dispose();
  }



// This widget is the root of your application.
  @override
  Widget build(BuildContext context)  => ChangeNotifierProvider(
  create: (context) => LocaleProvider(),
  builder: (context, child)
  {
    return GetMaterialApp(

      title: 'SFAX TOUR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('fr', ''),
        Locale('ar',''),
      ],

      home:SelectLangueScreen(),
    );});






  handleOpenLocationSettings() async {
    if (Platform.isAndroid) {
      Get.defaultDialog(
        title: 'Services de localisation désactivés',
        backgroundColor:  Color.fromRGBO(1, 168, 114, 1),
        contentPadding: EdgeInsets.all(50),
        content:           TextButton(

          onPressed: () async {
            Get.back();

            await flutterBeacon.openLocationSettings;

          },
          child: Text('Appuyez ici pour \nactiver le localisation',style: TextStyle(color: Colors.black38),textAlign: TextAlign.center,),
        ),


      );

    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Services Off'),
            content: Text(
              'Please enable Location Services on Settings > Privacy > Location Services.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  handleOpenBluetooth() async {
    if (Platform.isAndroid) {
      Get.defaultDialog(
        title: 'Le Bluetooth est désactivé',
        backgroundColor:  Color.fromRGBO(1, 168, 114, 1),
        contentPadding: EdgeInsets.all(25),

        content:           TextButton(

          onPressed: () async {
            Get.back();


            await flutterBeacon.openBluetoothSettings;

          },
          child: Text('Appuyez ici pour \nactiver le Bluetooth',style: TextStyle(color: Colors.black38),textAlign: TextAlign.center,),
        ),


      );

    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bluetooth is Off'),
            content: Text('Please enable Bluetooth on Settings > Bluetooth.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }









}

