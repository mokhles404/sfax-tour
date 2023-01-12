import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled1/Controller/Controller.dart';


class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  QuestionController _qnController=Get.put(QuestionController());
    return SafeArea(
      child: Scaffold(

        body:Stack(
          fit:StackFit.expand ,
          children: [
            Container(
              decoration: BoxDecoration(
                  image :DecorationImage(
                    image: AssetImage("assets/images/accueil.png"),
                    fit:BoxFit.fill,
                  )
              ),


            ),
            Column(
              children:[
                Spacer(flex: 3,),
                Container(


                  child: Text("Score" ,style: Theme.of(context).textTheme.headline3?.copyWith(
                    color:  Color(0xFF442C2E)
                  ),),
                ),
                Spacer(),
                Container(
                  width: 250,
                    height: 90,
                    decoration: BoxDecoration(
                        image :DecorationImage(
                          image: AssetImage("assets/images/score.png"),
                          fit:BoxFit.cover,
                        )
                    ),


                    child: Center(child: Text("${_qnController.numOfCorrectAnswer*10}/${_qnController.questions.length*10}", style: Theme.of(context).textTheme.headline4?.copyWith(color:Colors.amber ),))),
                Spacer(flex: 3,)


              ]

            )

          ],
        )
      ),
    );

  }
}