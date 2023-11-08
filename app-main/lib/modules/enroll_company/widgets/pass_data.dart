import 'package:get/get.dart';

class PassDataCustomPageView {

  static RxMap<String, dynamic> data = Map<String, dynamic>().obs;

  Stream get onData => data.stream;
  static set setData(Map<String, dynamic> value) {
    // log.info('setData: $value');
    data.value = value;
  }

}