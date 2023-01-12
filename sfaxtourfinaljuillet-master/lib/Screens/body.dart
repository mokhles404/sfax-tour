

import 'package:flutter/material.dart';

import 'package:untitled1/Model/Question.dart';
import 'package:untitled1/page/app_localizations.dart';


import '../constants/Constant.dart';
import 'QuestionCard.dart';


class Body extends StatelessWidget{

  const Body({
    Key? key,

    required this.question,
  }) : super(key: key);

  final Question question;


  @override
  Widget build (BuildContext context){



    // QuestionController _questionController = Get.put(QuestionController());
    return
    SafeArea(

    child: Container(
      decoration: BoxDecoration(
          image :DecorationImage(
            image: AssetImage("assets/images/accueil.png"),
            fit:BoxFit.fill,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Center(
            child: Container(

                padding: EdgeInsets.only(bottom:5.0,left: 20,right: 20,top: 10),
                // decoration: BoxDecoration(
                //     image :DecorationImage(
                //       image: AssetImage("assets/images/bandemaron.png"),
                //       fit:BoxFit.fill,
                //
                //     )
                // ),
                child: Text.rich(TextSpan(
                  text:AppLocalizations.of(context)!.translate('question').toString(),

                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color:   Color.fromRGBO(21, 49, 86, 1.0),
                      fontFamily: "Boogaloo",
                      fontSize: 45
                    )
                )


                )

            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.1),
            child: Image.asset("assets/images/trait.png"),
          ),

          // Padding(
          //
          //   padding:
          //
          //   const EdgeInsets.symmetric(horizontal:DefaultPadding),
          //
          //
          //      ),




                SizedBox(height: DefaultPadding,),

                Expanded(child: QuestionCard(question: question,)
                ),







    ],

      ),
    ),);
  }
}
