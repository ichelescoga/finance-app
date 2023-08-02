import 'package:get/get.dart';

abstract class BaseController extends GetxController{
  RxBool loading = false.obs;
  void updateLoadingStatus(bool status){
    loading.value = status;
  }
}