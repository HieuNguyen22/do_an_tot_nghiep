import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/modules/service/models/service.dart';

class ServicesProvider extends ServiceProvider {
  ServicesProvider() : super(provider: apiProvider);

  Future<List<Service>> getListService() async {
    /// Create list null
    List<Service> listService = [];
    try {
      /// Call api
      var response = await provider.get("/service/");
      var data = response.data["data"] as List;

      /// Convert json to object
      listService = data.map((data) => Service.fromJson(data)).toList();
    } catch (e) {
      listService = [];
    }

    return listService;
  }
}
