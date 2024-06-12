import 'package:get/get.dart';

class MapController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() async {
   

    await Future.delayed(const Duration(
      milliseconds: 3,
    )); // Simulate a delay for loading data
    isLoading.value = false;
  }
}
