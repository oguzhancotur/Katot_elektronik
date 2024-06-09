import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_event.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_state.dart';
import 'package:katot_elektronik/widgets/horizontal_card.dart';
import 'package:katot_elektronik/screens/jobpart/job_add.dart';

class JobTracking extends StatefulWidget {
  const JobTracking({super.key});

  @override
  State<JobTracking> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<JobTracking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<JobtrackingBloc, JobtrackingState>(
            builder: (context, state) {
          if (state is JobtrackingInitial) {
            context.read<JobtrackingBloc>().add(GetJobTracking());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobtrackingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobtrackingLoaded) {
            return Column(
              children: [
                Container(
                  child: Image.asset(
                    "assets/istakip.png",
                  ),
                ),
                Container(
                  child: Column(
                      children: state.jobtrackings
                          .map((e) => HorizontalCard(
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
            );
          } else if (state is JobtrackingError) {
            return const Center(
              child: Text("That's an error"),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobAdd(),
                ));
          },
          child: Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
