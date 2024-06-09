import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_event.dart';
import 'package:katot_elektronik/models/category_model.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({Key? key}) : super(key: key);

  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryQuantityController =
      TextEditingController();

  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Kategori Ekle"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(labelText: "Kategori Başlığı"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _categoryQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Kategori Adedi"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Kameradan Fotoğraf Yükle'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Galeriden Fotoğraf Yükle'),
              ),
              SizedBox(height: 16),
              if (_imageFile != null)
                Column(
                  children: [
                    Image.file(
                      _imageFile!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ElevatedButton(
                onPressed: () {
                  if (_imageFile != null &&
                      _categoryQuantityController.text.isNotEmpty) {
                    final int quantity =
                        int.tryParse(_categoryQuantityController.text) ?? 0;
                    context.read<StocktrackingBloc>().add(AddCategoriesEvent(
                        categoryModel: CategoryModel(
                          quantity: quantity,
                          image: null,
                          title: _categoryNameController.text,
                          categoryId: _categoryIdController.text,
                        ),
                        imageFile: _imageFile!));
                    context.read<StocktrackingBloc>().add(ResetEvent());
                    Navigator.pop(context);
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
