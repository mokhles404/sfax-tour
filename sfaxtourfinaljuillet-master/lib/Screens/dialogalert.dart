import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/page/app_localizations.dart';

import 'QuizScreen.dart';

class dialogalert extends StatelessWidget {
  final String content;
  final String title;

  const dialogalert({Key? key, required this.content, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.translate('okbtn').toString(),
        style: TextStyle(color: Colors.brown, fontSize: 25),
      ),
      onPressed: () {
        Get.to(QuizScreen());
        Navigator.pop(context);
      },
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pop up.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppLocalizations.of(context)!.translate(title).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              content,
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 16),
            ),
            okButton
          ],
        ),
      ),
    );
    /* AlertDialog(
       backgroundColor:  Color(0xFF442C2E),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          content,
          style: TextStyle(color: Colors.white),
        ),

       actions: [

         okButton,
       ],

    );*/
  }
}
