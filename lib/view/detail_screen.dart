import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/job_model.dart';

class DetailScreen extends StatelessWidget {
  final JobModel job;

  const DetailScreen({
    super.key,
    required this.job,
  });

  static const Color primaryColor = Color(0xFF5B3DF5);

  Future<void> openUrl() async {
    final Uri uri = Uri.parse(job.url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Widget buildChip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE5FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final createdDate =
    DateTime.fromMillisecondsSinceEpoch(
      job.createdAt * 1000,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                20,
                25,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5B3DF5),
                    Color(0xFF6D4AFF),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Row(
                children: [

                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Text(
                      "Job Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    /// COMPANY CARD
                    Container(
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFEAE5FF),
                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            ),
                            child: const Icon(
                              Icons.business,
                              color: primaryColor,
                              size: 40,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [

                                Text(
                                  job.title,
                                  style:
                                  const TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  job.companyName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors
                                        .grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// TAGS
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [

                        buildChip(
                          Icons.location_on,
                          job.location,
                        ),

                        if (job.jobTypes.isNotEmpty)
                          buildChip(
                            Icons.work,
                            job.jobTypes.first,
                          ),

                        if (job.tags.isNotEmpty)
                          buildChip(
                            Icons.tag,
                            job.tags.first,
                          ),

                        buildChip(
                          Icons.home_work,
                          job.remote
                              ? "Remote"
                              : "On Site",
                        ),

                        buildChip(
                          Icons.calendar_today,
                          DateFormat(
                            'dd MMM yyyy',
                          ).format(createdDate),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// JOB DESCRIPTION
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Html(
                        data: job.description,

                        onLinkTap:
                            (url, _, __) async {
                          if (url != null) {
                            await launchUrl(
                              Uri.parse(url),
                            );
                          }
                        },

                        style: {

                          "body": Style(
                            margin: Margins.zero,
                            padding:
                            HtmlPaddings.zero,
                            fontSize:
                            FontSize(15),
                            lineHeight:
                            const LineHeight(
                                1.8),
                          ),

                          "h2": Style(
                            fontSize:
                            FontSize(22),
                            fontWeight:
                            FontWeight.bold,
                            color:
                            primaryColor,
                            margin:
                            Margins.only(
                              top: 20,
                              bottom: 12,
                            ),
                          ),

                          "p": Style(
                            fontSize:
                            FontSize(15),
                            lineHeight:
                            const LineHeight(
                                1.8),
                            color:
                            Colors.black87,
                          ),

                          "ul": Style(
                            padding:
                            HtmlPaddings.only(
                              left: 12,
                            ),
                          ),

                          "li": Style(
                            fontSize:
                            FontSize(15),
                            lineHeight:
                            const LineHeight(
                                1.8),
                            margin:
                            Margins.only(
                              bottom: 10,
                            ),
                          ),

                          "a": Style(
                            color:
                            Colors.blue,
                            textDecoration:
                            TextDecoration
                                .underline,
                          ),
                        },
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            /// APPLY BUTTON
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withOpacity(
                      0.05,
                    ),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  onPressed: openUrl,

                  icon: const Icon(
                    Icons.open_in_new,
                  ),

                  label: const Text(
                    "Apply Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    primaryColor,
                    foregroundColor:
                    Colors.white,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}