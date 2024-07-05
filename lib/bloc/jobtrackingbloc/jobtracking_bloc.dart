import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingbloc/jobtracking_event.dart';
import 'package:katot_elektronik/bloc/jobtrackingbloc/jobtracking_state.dart';
import 'package:katot_elektronik/models/job_tracking_model.dart';
import 'package:katot_elektronik/repository/firebase_repo.dart';

class JobtrackingBloc extends Bloc<JobtrackingEvent, JobtrackingState> {
  FirestoreRepo firestoreRepo;
  JobtrackingBloc({required this.firestoreRepo}) : super(JobtrackingInitial()) {
    on<GetJobTracking>((event, emit) async {
      emit(JobtrackingLoading());
      try {
        final jobtrackingList = await firestoreRepo.getJobTracking();
        emit(JobtrackingLoaded(jobtrackings: jobtrackingList));
      } catch (e) {
        emit(JobtrackingError());
      }
    });

    on<AddJobTracking>((event, emit) async {
      try {
        await firestoreRepo.addJobTracking(
            event.jobTrackingModel, event.imageFiles);
        emit(JobtrackingInitial());
      } catch (e) {
        print(e);
      }
    });

    on<DeleteJobEvent>((event, emit) async {
      emit(JobtrackingLoading());
      try {
        await firestoreRepo.deleteJob(event.jobId);
        emit(JobtrackingInitial());
      } catch (e) {
        emit(JobtrackingError());
      }
    });

    on<SearchJobEvent>((event, emit) async {
      emit(JobtrackingLoading()); // Arama başladığında loading durumunu göster
      try {
        final List<QueryDocumentSnapshot> documents =
            await firestoreRepo.getJobTrackingWithSearch(event.searchTitle);
        final List<JobTrackingModel> jobTrackings = documents.map((doc) {
          final data =
              doc.data() as Map<String, dynamic>; // Doğru türde dönüşüm
          return JobTrackingModel.fromMap(data, doc.id);
        }).toList();
        emit(JobtrackingLoaded(
            jobtrackings:
                jobTrackings)); // Arama sonuçlarını yükleyen durumu gönder
      } catch (e) {
        emit(JobtrackingError()); // Hata durumunu göster
      }
    });

    on<ResetEvent>((event, emit) async {
      emit(JobtrackingInitial());
    });
  }
}
