import 'package:get/get.dart';
import '../../../../services/Streamer.dart';
import '../../../../services/Streamer_Service.dart';


class HomeController extends GetxController {
  final StreamerService _streamerService = StreamerService();

  var streamers = <Streamer>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStreamers();
  }

  void fetchStreamers() async {
    try {
      isLoading(true);
      var fetchedStreamers = await _streamerService.fetchStreamers();
      streamers.assignAll(fetchedStreamers);
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
