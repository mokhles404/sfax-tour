


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled1/Model/Question.dart';
import 'package:untitled1/Screens/ScoreScreen.dart';
import 'package:untitled1/Screens/dialogalert.dart';
import 'package:untitled1/constants/firebase.dart';
import 'BeaconController.dart';
import 'language_controller.dart';

class QuestionController extends GetxController with SingleGetTickerProviderMixin {

  static QuestionController instance = Get.find();
  late AnimationController _animationController;
  late Animation _animation;

// to access to animation outside
  Animation get animation => this._animation;

  late PageController _pageController;

  PageController get pageContr => this._pageController;


  //List<Question> _questions = List<String>.from(json["steps"].values);


  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;


  late int? _correctAnswer;

  int? get correctAns => this._correctAnswer;


  late int _isSelected;

  int get isSelected => this._isSelected;

  RxInt _questionNumber = 0.obs;

  RxInt get questionNumber => this._questionNumber;


  late int _numOfCorrectAnswer =0;

  int get numOfCorrectAnswer => this._numOfCorrectAnswer;


  final RxList<Question>_questions=RxList<Question>([]);
  List<Question> get questions => this._questions;
  String collection="questions";
  Question get question=>this.question;

  @override
  onReady() {
    super.onReady();
    _questions.bindStream(getAllQuestions());
  }

  Stream<List<Question>> getAllQuestions() {

      return firebaseFirestore.collection(collection).snapshots().map((query)
      {
        print(query.docs);
      return query.docs.map((item) => Question.fromMap(item.data())).toList();
  });}


  @override
  void onInit() {
    //animation duration 60 s //fill the progress bar within 60s
    _questions.bindStream(getAllQuestions());

    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        //like setstate
        update();
      });
//start animation
    _animationController.forward();
    _pageController = PageController();
    super.onInit();
  }
  void checkAns(Question question, int selectedIndex) {
    final controller = Get.find<BeaconController>();
    final AppLanguage localization = Get.put(AppLanguage());

    // because once user press any option then it will run
    _correctAnswer = question.answer;
    _isSelected = selectedIndex;

    if (_correctAnswer == _isSelected) {_numOfCorrectAnswer++;
    _questionNumber.value=_questionNumber.value+1;
    _isAnswered = true;

    Get.dialog(dialogalert(title: 'correct', content: localization.appLocal == Locale("fr")
        ? question.orientation_fr
        : localization.appLocal == Locale("en")
        ? question.orientation_en
        : question.orientation_ar ,));
    controller.setLastclosest(controller.closest);
print("*************************************");
print(_numOfCorrectAnswer);
print("*************************************");
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });

    }

    else {
      Get.dialog(dialogalert(title: 'wrong', content: '',));
      _isAnswered = false;


    }

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn

  }


  String getIndex(int index){

    return question.orientation_ar[index];


  }












  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      print("number qyestion "+ _questionNumber.value.toString());
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      print("elseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }



}