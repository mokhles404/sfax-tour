
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/Controller/Controller.dart';
import 'package:untitled1/Controller/language_controller.dart';
import 'package:untitled1/Model/Question.dart';

import '../constants/Constant.dart';
import '../page/app_localizations.dart';
import 'Option.dart';

class QuestionCard extends StatelessWidget {
   QuestionCard({
    Key? key,

    required this.question,
  }) : super(key: key);

  final Question question;
  final AppLanguage localization = Get.put(AppLanguage());
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    Size size =MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(DefaultPadding),


        child:Column(
          children: <Widget> [

            Flexible(
              child: Container(
                // height: 500,
                margin:  EdgeInsets.all(2.0),
                width: size.width*0.8,
                // height: 75,
                // decoration:BoxDecoration(
                //     // image :DecorationImage(
                //     //   image: AssetImage("assets/images/button-question@hdpi.png"),
                //     //   fit:BoxFit.cover,
                //     // )
                // ),


                child: AutoSizeText(localization.appLocal == Locale("fr")
                    ? question.question_fr 
                    : localization.appLocal == Locale("en")
                    ? question.question_en
                    : question.question_ar,
                    style : Theme.of(context).textTheme.headline6?.copyWith(color: Color(0xFF442C2E),fontFamily: "Boogaloo")),
              ),
            ),

            SizedBox(height: DefaultPadding/2,),

           ...List.generate(question.options.length, (index) => Option(index: index, text:  localization.appLocal == Locale("fr")
               ? question.options[index]["reponse_"+(index+1).toString()+"_FR"]
               : localization.appLocal == Locale("en")
               ? question.options[index]["reponse_"+(index+1).toString()+"_ENG"]
               : question.options[index]["reponse_"+(index+1).toString()+"_AR"],
             press: ()=> _questionController.checkAns(question, index),

            )),

            SizedBox(height: 20,),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child:AutoSizeText( localization.appLocal == Locale("fr")
                    ? question.orientation_fr
                    : localization.appLocal == Locale("en")
                    ? question.orientation_en
                    : question.orientation_ar , style : Theme.of(context).textTheme.headline6?.copyWith(color: Color(0xFF442C2E),fontSize: 12)),

                // decoration: BoxDecoration(
                //     image :DecorationImage(
                //       image: AssetImage("assets/images/ruban@hdpi.png"),
                //       fit:BoxFit.fill,
                //     )
                // ),



              ),
            ),

        Spacer(),

        AutoSizeText("${_questionController.numOfCorrectAnswer}"+AppLocalizations.of(context)!.translate('answerpoint').toString()+"8",style: TextStyle(fontFamily: "Boogaloo",fontSize: 20),)
        ,SizedBox(height: MediaQuery.of(context).size.width*0.15,)







          ],



        ),





    );


  }
}