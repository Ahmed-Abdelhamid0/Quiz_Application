import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';

class MyBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }

}