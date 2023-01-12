import 'package:flutter/material.dart';
import 'package:untitled1/page/app_localizations.dart';

class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/accueil.png"),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
             padding: EdgeInsets.all(15),
             child:  Text(AppLocalizations.of(context)!.translate('loadingMsg').toString(),
               textAlign: TextAlign.center,
               style: TextStyle(
                   fontSize: 25
               ),
             ),
           ),
            SizedBox(height: 50,),
            CircularProgressIndicator(color:  Color.fromRGBO(1, 168, 114, 1),)
          ],
        ),
      ),
    );
  }

}