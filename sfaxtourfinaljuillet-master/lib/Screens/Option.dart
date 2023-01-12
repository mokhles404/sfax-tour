

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/Controller/Controller.dart';
import 'package:untitled1/Controller/language_controller.dart';

import '../constants/Constant.dart';

class Option extends StatelessWidget {
   Option({
    Key? key, required this.text, required this.index, required this.press

    ,
  }) : super(key: key);
final String text ;
final int index;
final VoidCallback press;

   final AppLanguage localization = Get.put(AppLanguage());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (qnController) {

        Color getTheRightColor(){
          if (qnController.isAnswered){
            if(index==qnController.correctAns){
              return kGreenColor;
            } else if(index == qnController.isSelected && qnController.isSelected != qnController.correctAns) {
              return kRedColor;
            }


          }
          return kGrayColor;
        }

        IconData getTheRightIcon(){
          return getTheRightColor() == kRedColor ? Icons.close :Icons.done;
        }

        return InkWell(
          onTap: press,

          child: Container(
          // margin:  EdgeInsets.only(top:DefaultPadding),
            //padding: EdgeInsets.all(DefaultPadding),
            margin:  EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0),
            width: size.width*0.8,
            // height: 50,

            decoration: BoxDecoration(
                image :DecorationImage(
                  image: AssetImage("assets/images/button.png"),
                  fit:BoxFit.cover,
                ),

              border:Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(15),
            ),

            child:localization.appLocal == Locale("ar")
                ? Row(

              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                SizedBox(width: 10,),

                //const SizedBox(height: 50,),
                Container(
                  // height: 100,
                    width: MediaQuery.of(context).size.width*0.56,
                    child: AutoSizeText("$text",maxLines: 3,overflow:TextOverflow.ellipsis,textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF442C2E),fontSize: 16,fontWeight: FontWeight.bold),)),
                // SizedBox(width: 10,),
                Spacer(),
                Container(
                  height: 26 ,
                  width:26,
                  decoration: BoxDecoration(
                    color: getTheRightColor()== kGrayColor ? Colors.transparent : getTheRightColor(),
                    image :DecorationImage(
                      image: AssetImage("assets/images/radion-btn-off@hdpi.png"),
                      fit:BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xFF442C2E)),




                  ),

                  child: getTheRightColor() == kGrayColor ? null : Icon(getTheRightIcon(),size:16),
                ),
                SizedBox(width: 10,),
              ],
            )
                :  Row(

              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                SizedBox(width: 10,),

                //const SizedBox(height: 50,),
               Container(
                   // height: 100,
                 width: MediaQuery.of(context).size.width*0.56,
                   child: AutoSizeText("$text",maxLines: 3,overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: TextStyle(color: Color(0xFF442C2E),fontSize: 16,fontWeight: FontWeight.bold),)),
                // SizedBox(width: 10,),
Spacer(),
                Container(
                  height: 26 ,
                  width:26,
                  decoration: BoxDecoration(
                    color: getTheRightColor()== kGrayColor ? Colors.transparent : getTheRightColor(),
                    image :DecorationImage(
                      image: AssetImage("assets/images/radion-btn-off@hdpi.png"),
                      fit:BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xFF442C2E)),




                  ),

                  child: getTheRightColor() == kGrayColor ? null : Icon(getTheRightIcon(),size:16),
                ),
                SizedBox(width: 10,),
              ],
            ),

          ),
        );
      }
    );
  }
}