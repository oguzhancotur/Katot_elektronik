import 'dart:io';

import 'package:katot_elektronik/models/job_tracking_model.dart';

abstract class JobtrackingEvent {}

class GetJobTracking extends JobtrackingEvent {}

class AddJobTracking extends JobtrackingEvent {
  final JobTrackingModel jobTrackingModel;
  final List<File> imageFiles;

  AddJobTracking({
    required this.jobTrackingModel,
    required this.imageFiles,
  });
}

class DeleteJobEvent extends JobtrackingEvent {
  final String jobId;

  DeleteJobEvent({required this.jobId});

  List<Object> get props => [jobId];
}

class SearchJobEvent extends JobtrackingEvent {
  final String searchTitle;

  SearchJobEvent(this.searchTitle);
}

class ResetEvent extends JobtrackingEvent {}
