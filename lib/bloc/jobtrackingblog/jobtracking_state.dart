import 'package:katot_elektronik/models/job_tracking_model.dart';

abstract class JobtrackingState {}

final class JobtrackingInitial extends JobtrackingState {}

final class JobtrackingLoading extends JobtrackingState {}

final class JobtrackingLoaded extends JobtrackingState {
  List<JobTrackingModel> jobtrackings;

  JobtrackingLoaded({required this.jobtrackings});
}

final class JobtrackingError extends JobtrackingState {}
