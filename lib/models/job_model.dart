class JobModel {
  final String slug;
  final String companyName;
  final String title;
  final String description;
  final bool remote;
  final String url;
  final List<String> tags;
  final List<String> jobTypes;
  final String location;
  final int createdAt;

  JobModel({
    required this.slug,
    required this.companyName,
    required this.title,
    required this.description,
    required this.remote,
    required this.url,
    required this.tags,
    required this.jobTypes,
    required this.location,
    required this.createdAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      slug: json['slug'] ?? '',

      companyName:
      json['company_name'] ?? '',

      title:
      json['title'] ?? '',

      description:
      json['description'] ?? '',

      remote:
      json['remote'] ?? false,

      url:
      json['url'] ?? '',

      tags: json['tags'] != null
          ? List<String>.from(
        json['tags'],
      )
          : [],

      jobTypes:
      json['job_types'] != null
          ? List<String>.from(
        json['job_types'],
      )
          : [],

      location:
      json['location'] ?? '',

      createdAt:
      json['created_at'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'company_name': companyName,
      'title': title,
      'description': description,
      'remote': remote,
      'url': url,
      'tags': tags,
      'job_types': jobTypes,
      'location': location,
      'created_at': createdAt,
    };
  }
}