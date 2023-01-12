import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/page/app_localizations.dart';

import 'Welcome_Screen.dart';

class BienvenuQuiz extends StatelessWidget {
  const BienvenuQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/langues.png"),
                fit: BoxFit.fill,
              )),
              child: Stack(children: <Widget>[

                //SizedBox(height: 10,),

                Positioned(
                  top: MediaQuery.of(context).size.height*0.1,
                  left: MediaQuery.of(context).size.width / 5.3,
                  child: Container(
                    height: 110,
                    padding:
                        EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 10),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      AppLocalizations.of(context)!.translate('welcome').toString(),
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 40,
                        color:  Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SizedBox(height: 20),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.25,
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height*0.3,
                    child: AutoSizeText(
                      AppLocalizations.of(context)!.translate('descriptionGame').toString(),
                      maxLines: 7,

                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 30,
                        color: Color(0xFF442C2E),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),

                //  SizedBox(height: 10,),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 4.3,
                  left: MediaQuery.of(context).size.width / 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Get.to(WelcomeScreen()),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/button.png"),
                            fit: BoxFit.cover,
                          )),
                          child: Text(
                            AppLocalizations.of(context)!.translate('beginGame').toString() ,
                            style: TextStyle(
                              fontFamily: 'Boogaloo',
                              fontSize: 25,
                              color:  Color.fromRGBO(1, 168, 114, 1),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ])),
        ));
  }
}
