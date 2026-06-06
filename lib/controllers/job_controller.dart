import 'package:get/get.dart';

import '../models/job_model.dart';
import '../services/api_service.dart';

class JobController extends GetxController {

  var jobs = <JobModel>[].obs;

  var filteredJobs = <JobModel>[].obs;

  var loading = true.obs;

  var error = false.obs;

  var bookmarks = <String>{}.obs;

  @override
  void onInit() {
    fetchJobs();
    super.onInit();
  }

  Future<void> fetchJobs() async {

    try {

      loading.value = true;
      error.value = false;

      jobs.value = await ApiService.fetchJobs();

      filteredJobs.value = jobs;

    } catch (e) {

      error.value = true;

    } finally {

      loading.value = false;
    }
  }

  void search(String query) {

    filteredJobs.value = jobs.where((job) {

      return job.title
          .toLowerCase()
          .contains(query.toLowerCase()) ||

          job.companyName
              .toLowerCase()
              .contains(query.toLowerCase());

    }).toList();
  }

  void toggleBookmark(String title) {

    if (bookmarks.contains(title)) {
      bookmarks.remove(title);
    } else {
      bookmarks.add(title);
    }
  }
}