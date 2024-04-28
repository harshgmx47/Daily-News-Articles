import 'package:get/get.dart';

class TabsController extends GetxController {
  RxBool slidable = false.obs;

  RxBool isNewsTabSelected = false.obs;
  RxBool isFavsTabSelected = false.obs;

  bool get newsTabSelected => isNewsTabSelected.value;
  bool get favsTabSelected => isFavsTabSelected.value;
  @override
  void onInit() {
    isNewsTabSelected(true);
    super.onInit();
  }
}
