import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';
import 'package:quiz_app/widgets/custom_button.dart';
import 'package:quiz_app/widgets/progress_timer.dart';
import 'package:quiz_app/widgets/question_card.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(

              image: DecorationImage(
                  image: AssetImage('assets/images/testt2.jpg'),
                  fit: BoxFit.cover),
                color: Colors.black87,

            ),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Question ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: controller.numberOfQuestions
                                          .round()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.white)),
                                  TextSpan(
                                      text: '/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white)),
                                  TextSpan(
                                      text: controller.countOfQuestion.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white)),
                                ]),
                          ),
                          ProgressTimer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionList[index],
                        ),
                        controller: controller.pageController,
                        itemCount: controller.questionList.length,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(
            onPressed: () => controller.nextQuestion(), text: 'Next'),
      ),
    );
  }
}
