

class Question{

 int id=0,answer=0;
  String question_ar="";
  String question_fr="";
  String question_en="";

  String proximityUUID="";

  List<Map>options=[] ;

 String orientation_fr="";
 String orientation_ar ="";
 String orientation_en="";

Question( {required this.proximityUUID, required this.id,required this.answer, required this.options});


Question.fromMap(Map<String, dynamic> data) {


      orientation_ar =  data["destination_AR"] ?? "";
      orientation_fr =  data["destination_FR"] ?? "" ;
      orientation_en =  data["destination-ENG"] ?? "" ;
      id =  data["Numuero"]  as int ;
      answer = data["answer"] as int ;
      question_ar= data["Question_AR"]?? "" ;
      question_en= data["Question_ENG"] ?? "" ;
      question_fr= data["Question_FR"] ?? "" ;
      options=(data["options"] as  List<dynamic>).map((e) => e as Map).toList();
      proximityUUID=data["proximityUUID"] as String ;


}

}



