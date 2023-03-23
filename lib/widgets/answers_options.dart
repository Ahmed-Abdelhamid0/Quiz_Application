import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';

class AnswerOptions extends StatelessWidget {
  String text;
  int index;
  int questionID;
  Function()onPressed;
  
  AnswerOptions(
      {
        required this.text,
        required this.index,
        required this.questionID,
        required this.onPressed,
      });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController() ,
        builder: (controller)=> InkWell(
          onTap: controller.checkIsQuestionAnswerd(questionID) ? null : onPressed,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width:  3,color: controller.getColor(index))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '${index + 1}. ',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: text,
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                    if (controller.checkIsQuestionAnswerd(questionID) &&
                        controller.selectedAnswer == index)
                      Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: controller.getColor(index),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              shape: BoxShape.circle),
                          child: Icon(
                            controller.getIcon(index),
                            color: Colors.white,
                          ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
