import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:katot_elektronik/models/category_model.dart';
import 'package:katot_elektronik/models/job_tracking_model.dart';

class FirestoreRepo {
  final firebaseStorageInstance =
      FirebaseStorage.instance; // Firebase Storage ile bağlantı yapıldı.
  final firebaseFirestoreInstance =
      FirebaseFirestore.instance; //firestore ile baglantı yapıldı.

  Future<List<JobTrackingModel>> getJobTracking() async {
    final jobSnapshot =
        await firebaseFirestoreInstance.collection("jobs").get();
    final jobList = jobSnapshot.docs.map((e) {
      return JobTrackingModel.fromMap(e.data(), e.id);
    }).toList();

    return jobList;
  }

  // Firestore'da jobs koleksiyonuna veri eklemek için metot
  Future<void> addJobTracking(
      JobTrackingModel jobTrackingModel, List<File> imageFiles) async {
    try {
      List<String> photoUrls = [];

      // İş takibinin resim dosyalarını Firebase Storage'a yükle
      for (File imageFile in imageFiles) {
        // Resmin Storage'da tutulacağı yol (örneğin: jobs/job_id/image1.jpg)

        // Firebase Storage'a resmi yükle
        final ref = firebaseStorageInstance
            .ref()
            .child("jobs")
            .child("${jobTrackingModel.title}")
            .child(DateTime.now().millisecondsSinceEpoch.toString());

        await ref.putFile(imageFile);
        final photoUrl = await ref.getDownloadURL();
        photoUrls.add(photoUrl);
      }
      // İş takibi verisini Firestore'a ekle
      await firebaseFirestoreInstance.collection("jobs").add(JobTrackingModel(
              title: jobTrackingModel.title,
              corporation: jobTrackingModel.corporation,
              explanation: jobTrackingModel.explanation,
              state: jobTrackingModel.state,
              jobId: jobTrackingModel.jobId,
              image: photoUrls)
          .toMap());
    } catch (e) {
      // Hata durumunda işlemi ele al
      print('Hata oluştu: $e');
      throw Exception('İşlem sırasında bir hata oluştu.');
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      await firebaseFirestoreInstance.collection('jobs').doc(jobId).delete();
    } catch (e) {
      throw Exception('İş silinirken bir hata oluştu: $e');
    }
  }

  Future<List<QueryDocumentSnapshot>> getJobTrackingWithSearch(
      String searchTitle) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .where('title', isEqualTo: searchTitle)
          .get();

      final List<QueryDocumentSnapshot> documents = snapshot.docs;
      return documents;
    } catch (e) {
      print('İş takibi aranırken hata oluştu: $e');
      throw Exception('İş takibi aranırken hata oluştu.');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    final jobSnapshot =
        await firebaseFirestoreInstance.collection("categories").get();
    final categoryList = jobSnapshot.docs.map((e) {
      return CategoryModel.fromMap(e.data(), e.id);
    }).toList();

    return categoryList;
  }

  Future<void> addCategory(CategoryModel categoryModel, File imageFile) async {
    try {
      // İş takibinin resim dosyalarını Firebase Storage'a yükle

      // Resmin Storage'da tutulacağı yol (örneğin: jobs/job_id/image1.jpg)

      // Firebase Storage'a resmi yükle
      final ref = firebaseStorageInstance
          .ref()
          .child("categories")
          .child("${categoryModel.title}")
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(imageFile);
      final photoUrl = await ref.getDownloadURL();

      // İş takibi verisini Firestore'a ekle
      await firebaseFirestoreInstance.collection("categories").add(
          CategoryModel(
                  image: photoUrl,
                  title: categoryModel.title,
                  categoryId: categoryModel.categoryId,
                  quantity: categoryModel.quantity)
              .toMap());
    } catch (e) {
      // Hata durumunda işlemi ele al
      print('Hata oluştu: $e');
      throw Exception('İşlem sırasında bir hata oluştu.');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await firebaseFirestoreInstance
          .collection('categories')
          .doc(categoryId)
          .delete();
    } catch (e) {
      throw Exception('kategori silinirken bir hata oluştu: $e');
    }
  }
}
