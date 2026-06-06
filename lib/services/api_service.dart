import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class ApiService {

  static Future<List<JobModel>> fetchJobs() async {

    final response = await http.get(
      Uri.parse(
        "https://www.arbeitnow.com/api/job-board-api",
      ),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List jobs = data['data'];

      return jobs
          .map((e) => JobModel.fromJson(e))
          .toList();
    }

    throw Exception("Failed to load jobs");
  }
}