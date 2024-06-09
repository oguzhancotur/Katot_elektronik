import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_event.dart';
import 'package:katot_elektronik/models/job_tracking_model.dart';

class JobAdd extends StatefulWidget {
  const JobAdd({super.key});

  @override
  _JobAddState createState() => _JobAddState();
}

class _JobAddState extends State<JobAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobnameController = TextEditingController();
  final TextEditingController _corporationController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();
  final TextEditingController _jobIdController = TextEditingController();

  final List<File> _imageFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  String dropDownValue = "Başlanmadı";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("İş Ekle"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              TextFormField(
                controller: _jobnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    label: const Text("İş Başlığı"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.all(18)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null; // Geçerli değer döndür
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _corporationController,
                decoration: InputDecoration(
                    label: const Text("İş Yapılan Kurum"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.all(18)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null; // Geçerli değer döndür
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: _explanationController,
                decoration: InputDecoration(
                    label: const Text("Açıklama"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.all(18)),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null; // Geçerli değer döndür
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              DropdownButtonFormField<String>(
                value: dropDownValue,
                decoration: InputDecoration(
                    label: const Text("Durum"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.all(18)),
                items: const [
                  DropdownMenuItem(
                    value: 'Başlanmadı',
                    child: Text('Başlanmadı'),
                  ),
                  DropdownMenuItem(
                      value: 'Yapım Aşamasında',
                      child: Text('Yapım Aşamasında')),
                  DropdownMenuItem(
                    value: 'Yapıldı',
                    child: Text('Yapıldı'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text(
                  'Kameradan Fotoğraf Yükle',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: const Text(
                  'Galeriden Fotoğraf Yükle',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (_imageFiles.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      _imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<JobtrackingBloc>().add(AddJobTracking(
                        jobTrackingModel: JobTrackingModel(
                            image: null,
                            title: _jobnameController.text,
                            explanation: _explanationController.text,
                            corporation: _corporationController.text,
                            jobId: _jobIdController.text,
                            state: dropDownValue),
                        imageFiles: _imageFiles));
                    context.read<JobtrackingBloc>().add(ResetEvent());
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
