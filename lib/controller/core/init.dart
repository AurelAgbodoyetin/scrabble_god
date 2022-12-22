import 'package:get/get.dart';
import 'package:scrabble_god/controller/data.dart';

Future<void> initControllers() async {
  Get.put(DataController());
}
