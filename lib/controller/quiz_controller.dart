import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/layout/welcome_screen.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/result/result_screen.dart';

class QuizController extends GetxController
{
  String name = '';
  final List <QuestionModel> _questionList =
  [
    QuestionModel(
        id: 1,
        question: ' A sequence of asynchronous Flutter events is known as a:',
        answer: 2 ,
        options:
        [
          'Flow',' Current' , 'Stream','Series'],
    ),
    QuestionModel(
      id: 2,
      question: 'Who developed the Flutter Framework and continues to maintain it today?',
      answer: 3 ,
      options:
      [
        'Facebook',' Microsoft' , 'Oracle','Google'],
    ),
    QuestionModel(
      id: 3,
      question: 'Which programming language is used to build Flutter applications?',
      answer: 1 ,
      options:
      [
        'Kotlin',' Dart' , 'Java','Go'],
    ),
    QuestionModel(
      id: 4,
      question: 'How many types of widgets are there in Flutter?',
      answer: 0 ,
      options:
      [
        '2',' 4' , '6','+8'],
    ),
    QuestionModel(
      id: 5,
      question: 'Access to a cloud database through Flutter is available through which service?',
      answer: 1 ,
      options:
      [
        'SQLite',' Firebase Database' , 'NOSQL','MYSQL'],
    ),
    QuestionModel(
      id: 6,
      question: 'What element is used as an identifier for components when programming in Flutter?',
      answer: 1 ,
      options:
      [
        'Widgets',' Keys' , 'Elements','Serial'],
    ),
    QuestionModel(
      id: 7,
      question: 'What type of test can examine your code as a complete system?',
      answer: 2 ,
      options:
      [
        'Unit tests',' Widget tests ' , 'Integration Tests','All of the above'],
    ),
    QuestionModel(
      id: 8,
      question: 'True or false: Flutter boasts improved runtime performance over most application frameworks.',
      answer: 0 ,
      options: ['True',' False'],
    ),
    QuestionModel(
      id: 9,
      question: 'Which function will return the widgets attached to the screen as a root of the widget tree to be rendered on screen?',
      answer: 1 ,
      options:
      [
        'main()',' runApp() ' , 'container()','root()'],
    ),
    QuestionModel(
      id: 10,
      question: 'True or false: an experienced Flutter developer doesn\'t need to know platform native languages or tools to build apps.',
      answer: 1 ,
      options: ['True',' False'],
    ),
  ];

  bool _isPressed = false;
  double _numberOfQuestions = 1;
  int? _selectedAnswer;
  int _countOfCorrectAnswer = 0;
  final RxInt _sec=15.obs;



  bool get isPressed => _isPressed;
  int get countOfQuestion => _questionList.length;
  List<QuestionModel> get questionList => [..._questionList];
  double get numberOfQuestions => _numberOfQuestions;
  int? get selectedAnswer => _selectedAnswer;
  int get countOfCorrectAnswer => _countOfCorrectAnswer;
  RxInt get sec => _sec;
  int? _correctAnswer;
  final Map<int,bool> __questionIsAnswerd={};
  Timer? _timer;
  final maxSecond=15;
  late PageController pageController;

  @override
  void onInit() {
    pageController =PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
  double get scoreResult {
    return countOfCorrectAnswer *100/_questionList.length;
  }
  void checkAnswer(QuestionModel questionModel,int selectedAnswer){
    _isPressed = true;
    _selectedAnswer=selectedAnswer;
    _correctAnswer=questionModel.answer;
    if(_correctAnswer==_selectedAnswer)
    {
      _countOfCorrectAnswer++;
    }
    stopTimer();
    __questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());


    update();
  }
  bool checkIsQuestionAnswerd(int questionID) {
  return __questionIsAnswerd.entries.firstWhere((element) => element.key==questionID).value;
}
  nextQuestion() {
    if(_timer!=null || _timer!.isActive)
      {
        stopTimer();
      }
    if(pageController.page==_questionList.length-1)

      {
        Get.offAndToNamed(ResultScreen.routeName);      }
    else
    {
      _isPressed=false;
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,);
        startTimer();

    }
    _numberOfQuestions=pageController.page!+2;
    update();
  }
  void resetAnswer() {
    for(var element in _questionList )
      {
        __questionIsAnswerd.addAll({element.id: false});
      }
    update();
  }
  Color getColor(int answerIndex){

    if(_isPressed)
    {
      if(answerIndex==_correctAnswer)
      {
        return Colors.green;
      }
      else if(answerIndex==_selectedAnswer && _correctAnswer!=_selectedAnswer)
      {
        return Colors.red;

      }

    }
    return Colors.white;
  }
  IconData getIcon(int answerIndex){

    if(_isPressed)
    {
      if(answerIndex==_correctAnswer)
      {
        return Icons.done;
      }
      else if(answerIndex==_selectedAnswer && _correctAnswer!=_selectedAnswer)
      {
        return Icons.close;

      }

    }
    return Icons.close;
  }
  void startTimer() {
    resetTimer();
    _timer=Timer.periodic(const Duration(seconds: 1), (timer)
    {
      if(_sec.value>0)
      {
        _sec.value--;
      }
      else
      {
        stopTimer();
        nextQuestion();
      }
    });
  }
  void startAgain () {
    _correctAnswer=null;
    _countOfCorrectAnswer=0;
    _selectedAnswer=null;
    resetAnswer();
    Get.offAndToNamed(WelcomeScreen.routeName);
  }
  void stopTimer() => _timer!.cancel();
  void resetTimer() => _sec.value=maxSecond;




}