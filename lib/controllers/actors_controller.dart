import 'package:get/get.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs;
  var mainTopRatedPersons = <Actor>[].obs;
  var watchListMovies = <Actor>[].obs;
  @override
  void onInit() async {
    isLoading.value = true;
    mainTopRatedPersons.value = (await ApiService.getTopPerson())!;
    isLoading.value = false;
    super.onInit();
  }

  bool isInWatchList(Actor movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  }

  void addToWatchList(Actor movie) {
    if (watchListMovies.any((m) => m.id == movie.id)) {
      watchListMovies.remove(movie);
      Get.snackbar('Success', 'removed from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListMovies.add(movie);
      Get.snackbar('Success', 'added to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
