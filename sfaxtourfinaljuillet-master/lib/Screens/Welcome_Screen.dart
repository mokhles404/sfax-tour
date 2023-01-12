import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Controller/language_controller.dart';

import 'package:get/get.dart';
import 'package:untitled1/page/app_localizations.dart';
import '../constants/Constant.dart';
import 'QuizScreen.dart';

class WelcomeScreen extends StatelessWidget{
  final AppLanguage localization = Get.put(AppLanguage());
  @override
  Widget build(BuildContext context){

    return SafeArea(
      child: Scaffold(

        body:
             Container(
               height: MediaQuery.of(context).size.height,
               decoration: BoxDecoration(
                 image :DecorationImage(
                   image: AssetImage("assets/images/accueil.png"),
                   fit:BoxFit.fill,
                 )
               ),

               child:   Padding(

                     padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),

                     child: Container(

                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget> [

                           Center(

                             child: Column(


                               children: [

                                 SizedBox(height: 80,),

                                 Container(
                                   padding: EdgeInsets.only(bottom: 0,left: 20,right: 20,top: 10),
                                   width: MediaQuery.of(context).size.width/1.5,

                                   decoration: BoxDecoration(
                                       // image :DecorationImage(
                                       //   image: AssetImage("assets/images/bienvenue.png"),
                                       //   fit:BoxFit.fill,
                                       // )
                                   ),
                                   child:Text(AppLocalizations.of(context)!.translate('welcome').toString() ,
                                     style: TextStyle(
                                       fontFamily: 'Boogaloo',
                                       fontSize: 40,
                                       color: Color.fromRGBO(21,49, 86, 1.0),
                                       fontWeight: FontWeight.w900,
                                     ),
                                     textAlign: TextAlign.center  ,


                                   ),

                                 ),
                                        Image.asset("assets/images/Logo Sfax Tour.png",width: 120,),
                                 SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: InkWell(

                                     onTap: () => Get.to(QuizScreen()),
                                     child: Center(
                                       child: Container(
                                         padding: EdgeInsets.all(20),
                                           width: MediaQuery.of(context).size.width/1.5,
                                           height: 80,
                                           decoration: BoxDecoration(
                                               image :DecorationImage(
                                                 // colorFilter: ColorFilter.linearToSrgbGamma()!,
                                                 image: AssetImage("assets/images/button.png"),
                                                 fit:BoxFit.fill,
                                               )
                                           ),
                                           child:Text(AppLocalizations.of(context)!.translate('kasba').toString() ,
                                             style: TextStyle(
                                               fontFamily: 'Boogaloo',
                                               fontSize: 30,
                                               color:  Color.fromRGBO(1, 168, 114, 1),
                                               fontWeight: FontWeight.w900,
                                             ),
                                             textAlign: TextAlign.center  ,


                                           ),


                                       ),
                                     ),),
                                 ),


                                 // Padding(
                                 //   padding: const EdgeInsets.all(8.0),
                                 //   child: InkWell(
                                 //     onTap: () => Get.to(descriptionMesuim()),
                                 //     child: Container(
                                 //       padding: EdgeInsets.all(20),
                                 //       width: MediaQuery.of(context).size.width/1.5,
                                 //       height: 80,
                                 //         decoration: BoxDecoration(
                                 //
                                 //             image :DecorationImage(
                                 //               // colorFilter: ColorFilter.linearToSrgbGamma()!,
                                 //
                                 //               image: AssetImage("assets/images/button.png"),
                                 //               fit:BoxFit.fill,
                                 //             )
                                 //         ),
                                 //
                                 //
                                 //
                                 //         child:Text(AppLocalizations.of(context)!.translate('traditionnel').toString() ,
                                 //             style: TextStyle(
                                 //               fontFamily: 'Boogaloo',
                                 //               fontSize: 30,
                                 //               color:  Color.fromRGBO(1, 168, 114, 1),
                                 //               fontWeight: FontWeight.w900,
                                 //             ),textAlign: TextAlign.center),
                                 //
                                 //     ),),
                                 // ),


                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: InkWell(

                                     // onTap: () => Get.to(QuizScreen()),
                                     child: Center(
                                       child: Container(
                                         padding: EdgeInsets.all(20),
                                         width: MediaQuery.of(context).size.width/1.5,
                                         height: 80,
                                           decoration: BoxDecoration(
                                               image :DecorationImage(
                                                 image: AssetImage("assets/images/button.png"),
                                                 fit:BoxFit.fill,
                                                 opacity: 0.3
                                               )
                                           ),



                                           child:AutoSizeText(AppLocalizations.of(context)!.translate('athari').toString(),
                                             style: TextStyle(
                                               fontFamily: 'Boogaloo',
                                               fontSize: 30,
                                               color: Color.fromRGBO(1, 168, 114, 1),
                                               fontWeight: FontWeight.w900,
                                             ),textAlign: TextAlign.center  ,),

                                       ),
                                     ),),
                                 ),



                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
             ),
      ),
    );
  }

}