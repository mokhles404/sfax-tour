

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled1/Controller/Controller.dart';

import '../constants/Constant.dart';
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF3F4768),width: 3),
            borderRadius: BorderRadius.circular(50)
        ),

        child: GetBuilder<QuestionController>(
          init: QuestionController(),
          builder: (controller) {
            // print(controller.animation.value);
            return Stack(
              children: [
                LayoutBuilder(builder: (context,constraints)=>Container(
                  //takes 60 s from 0 to 1
                  width: constraints.maxWidth*controller.animation.value,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(50)

                  ),


                )),
                Positioned.fill(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:DefaultPadding/2),
                  child: Row(

                    children: [Text("${(controller.animation.value * 60).round()} sec")],
                  ),
                ))

              ],
            );
          }
        )
    );
  }
}