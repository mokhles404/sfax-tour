import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/Controller/language_controller.dart';
import 'package:untitled1/page/app_localizations.dart';

import 'bienvenu_quizScreen.dart';

class SelectLangueScreen extends StatefulWidget {
   SelectLangueScreen({Key? key}) : super(key: key);

  @override
  State<SelectLangueScreen> createState() => _SelectLangueScreenState();
}

class _SelectLangueScreenState extends State<SelectLangueScreen> {
  final AppLanguage localization = Get.put(AppLanguage());



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    checkinitconnection();


  }

  checkinitconnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());

    if( connectivityResult== ConnectivityResult.none){

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Connexion est désactivée"),
          content: Text("votre connexion est désactivée veuillez l'activer"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

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
                // Positioned(
                //   top: 10,
                //   child: Container(
                //     height: 100,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage("assets/images/ruban@hdpi.png"),
                //           fit: BoxFit.fill,
                //         )),
                //   ),
                // ),
                //SizedBox(height: 10,),

                Positioned(
                  top: MediaQuery.of(context).size.height*0.08,
                  left: MediaQuery.of(context).size.width / 3.75,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.23,
                    padding:
                    EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 10),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Logo Sfax Tour.png"),
                          fit: BoxFit.fill,
                        )),
                    child: Text(
                      AppLocalizations.of(context)!.translate('welcome').toString() ,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 30,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SizedBox(height: 20),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.3,
                  child: Container(

                    padding: EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      AppLocalizations.of(context)!.translate('chooseLang').toString() ,
                      maxLines: 5,

                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 25,
                        color: Color(0xFF442C2E),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                //  SizedBox(height: 10,),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 3.5,
                child:  Container(
                  width: MediaQuery.of(context).size.width ,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            localization.changeLanguage(Locale("fr"));
                            Get.updateLocale(Locale("fr"));
                            print("changed fr!!");
                            Get.to(BienvenuQuiz());

                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/button.png"),
                                    fit: BoxFit.cover,
                                  )),
                              child: Text(
                                " Français ",
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 25,
                                  color: Color.fromRGBO(1, 168, 114, 1),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),



                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () async {

                        // await    firebaseFirestore.collection("questions").doc().set(
                        //     );
                            localization.changeLanguage(Locale("ar"));
                            Get.updateLocale(Locale("ar"));
                            print("changed ar!!");
                            Get.to(BienvenuQuiz());

                          },
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
                                " عربي ",
                                style: TextStyle(
                                  fontFamily: 'Hayah',
                                  fontSize: 28,
                                  color:  Color.fromRGBO(1, 168, 114, 1),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),



                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            localization.changeLanguage(Locale("en"));
                            Get.updateLocale(Locale("en"));
                            print("changed en!!");
                            Get.to(BienvenuQuiz());
                          },
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
                                " English ",
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

                    ],
                  ),
                )),

                // Align(
                //     alignment: Alignment.bottomRight,
                //     child: Image.asset("assets/images/bousole@hdpi.png")
                // ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: SizedBox(
                //     height: 150,
                //     width: 150,
                //     child: Image.asset("assets/images/treasure@hdpi.png"),
                //   ),
                // ),
              ])),
        ));
  }
}
