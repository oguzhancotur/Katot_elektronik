import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingbloc/jobtracking_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingbloc/jobtracking_event.dart';
import 'package:katot_elektronik/bloc/jobtrackingbloc/jobtracking_state.dart';
import 'package:katot_elektronik/screens/bottomnavigationbar.dart';
import 'package:katot_elektronik/widgets/job_tracking_card.dart';
import 'package:katot_elektronik/screens/jobpart/job_add.dart';

class JobTracking extends StatefulWidget {
  const JobTracking({Key? key}) : super(key: key);

  @override
  State<JobTracking> createState() => _JobTrackingState();
}

class _JobTrackingState extends State<JobTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("İŞ TAKİP SAYFASI"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ));
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          BlocBuilder<JobtrackingBloc, JobtrackingState>(
            builder: (context, state) {
              if (state is JobtrackingInitial) {
                context.read<JobtrackingBloc>().add(GetJobTracking());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is JobtrackingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JobtrackingLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Image.asset(
                        "assets/logo.png",
                        scale: 3.3,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.002),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Ara",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.004,
                      ),
                      Container(
                        child: Column(
                            children: state.jobtrackings
                                .map((e) => JobTrackingCard(
                                      image: e.image!,
                                      title: e.title,
                                      explanation: e.explanation,
                                      corporation: e.corporation,
                                      state: e.state,
                                      jobId: e.jobId,
                                    ))
                                .toList()),
                      ),
                    ],
                  ),
                );
              } else if (state is JobtrackingError) {
                return const Center(
                  child: Text("Bir hata oluştu"),
                );
              } else {
                return const Center(
                  child: Text("Bir şeyler ters gitti"),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF456268),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JobAdd(),
            ),
          );
        },
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
