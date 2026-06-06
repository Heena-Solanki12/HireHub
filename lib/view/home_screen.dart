import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/job_controller.dart';
import '../models/job_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final JobController controller = Get.put(JobController());

  static const Color primaryColor = Color(0xFF5B3DF5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                30,
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

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: const [

                      Text(
                        "HireHub",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// SEARCH BAR
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: TextField(
                      onChanged: controller.search,
                      decoration: const InputDecoration(
                        hintText:
                        "Search jobs by title or company",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// TITLE
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "All Jobs",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Obx(
                        () => Text(
                      "${controller.filteredJobs.length} jobs found",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// JOB LIST
            Expanded(
              child: Obx(() {

                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.error.value) {
                  return Center(
                    child: ElevatedButton(
                      onPressed:
                      controller.fetchJobs,
                      child: const Text(
                        "Try Again",
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  itemCount:
                  controller.filteredJobs.length,

                  itemBuilder: (context, index) {

                    final JobModel job =
                    controller.filteredJobs[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                              () => DetailScreen(
                            job: job,
                          ),
                        );
                      },

                      child: Container(
                        margin:
                        const EdgeInsets.only(
                          bottom: 15,
                        ),

                        padding:
                        const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                0.05,
                              ),
                              blurRadius: 12,
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            /// COMPANY LOGO
                            Container(
                              width: 70,
                              height: 70,

                              decoration:
                              BoxDecoration(
                                color: Colors.grey
                                    .shade100,

                                borderRadius:
                                BorderRadius
                                    .circular(
                                  18,
                                ),
                              ),

                              child: const Icon(
                                Icons.business,
                                size: 35,
                                color:
                                primaryColor,
                              ),
                            ),

                            const SizedBox(width: 15),

                            /// JOB INFO
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
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 5),

                                  Text(
                                    job.companyName,
                                    style:
                                    TextStyle(
                                      color: Colors
                                          .grey
                                          .shade700,
                                      fontSize:
                                      15,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons
                                            .location_on,
                                        size: 16,
                                        color:
                                        primaryColor,
                                      ),

                                      const SizedBox(
                                          width:
                                          4),

                                      Expanded(
                                        child:
                                        Text(
                                          job.location,
                                          style:
                                          TextStyle(
                                            color: Colors
                                                .grey
                                                .shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 10),

                                  Container(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                      horizontal:
                                      12,
                                      vertical: 5,
                                    ),

                                    decoration:
                                    BoxDecoration(
                                      color:
                                      const Color(
                                        0xFFEAE5FF,
                                      ),

                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                        20,
                                      ),
                                    ),

                                    child:
                                    const Text(
                                      "Full Time",
                                      style:
                                      TextStyle(
                                        color:
                                        primaryColor,
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// FAVORITE
                            IconButton(
                              icon: Icon(
                                controller
                                    .bookmarks
                                    .contains(
                                    job
                                        .title)
                                    ? Icons
                                    .favorite
                                    : Icons
                                    .favorite_border,

                                color: controller
                                    .bookmarks
                                    .contains(
                                    job
                                        .title)
                                    ? Colors.red
                                    : Colors.grey,
                              ),

                              onPressed: () {
                                controller
                                    .toggleBookmark(
                                  job.title,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}