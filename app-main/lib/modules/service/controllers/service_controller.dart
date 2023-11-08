import 'package:get/get.dart';
import 'package:app_work_log/modules/service/models/service.dart';
import 'package:app_work_log/modules/service/provider/services_provider.dart';

class ServiceController extends GetxController {
  var checkChooseSecive = (-1).obs;
  var listService = <Service>[].obs;
  var isLoadding = false.obs;
  @override
  void onReady() {
    super.onReady();
    fetchService();
  }

  /// Get service
  void fetchService() async {
    isLoadding.value = true;
    var result = await ServicesProvider().getListService();
    listService.value = result;
    isLoadding.value = false;
  }

}
