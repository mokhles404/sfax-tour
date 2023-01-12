
import 'package:flutter/material.dart';
import 'package:untitled1/page/app_localizations.dart';



class descriptionMesuim extends StatelessWidget {


  const descriptionMesuim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(21, 49, 86, 1.0),
      elevation: 0,
      leading: Container(),
      actions:[
      GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Image.asset("assets/images/retour.png"),
      ) ,
      ]
    ),
    body:
    Container(
      height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    image :DecorationImage(
        image: AssetImage("assets/images/accueil.png"),
    fit:BoxFit.cover,
  )
    ),
      child:

      SingleChildScrollView(

        child: Container(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.translate("traditionnel").toString(),
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 56,
                        color: Color(0xFF442C2E),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.end,
                    ),

                    Divider(color: Color(0xFF442C2E)),
                    SizedBox(height: 32),
                    Text(AppLocalizations.of(context)!.translate('descAntique').toString(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 20,
                        color: Color(0xFF442C2E),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                   /* SizedBox(height: 32),
                    Divider(color: Color(0xFF442C2E)),*/
                  ],
                ),
              ),
          /*    Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  'بعد الإستماع إلى هذا التعريف توجه يسارا نحو قاعة الخروجات',
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 25,
                    color: const Color(0xFF442C2E),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),*/

            ],
          ),
        ),
      ),

    ));
  }


}
