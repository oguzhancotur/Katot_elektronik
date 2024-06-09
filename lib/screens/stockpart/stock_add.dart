import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_event.dart';
import 'package:katot_elektronik/models/stock_tracking_model.dart';

class StockAdd extends StatefulWidget {
  const StockAdd({Key? key}) : super(key: key);

  @override
  _StockAddState createState() => _StockAddState();
}

class _StockAddState extends State<StockAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _shelfNumberController = TextEditingController();
  final TextEditingController _valueEController = TextEditingController();
  final TextEditingController _voltageController = TextEditingController();
  final TextEditingController _wattController = TextEditingController();
  final TextEditingController _toleransController = TextEditingController();
  final TextEditingController _footPrintController = TextEditingController();

  final List<File> _imageFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stok Ekle"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Stok Başlığı"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir stok başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Stok Adedi"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir stok adedi girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _shelfNumberController,
                  decoration: InputDecoration(labelText: "Raf Numarası"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Raf Numanası girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _valueEController,
                  decoration: InputDecoration(labelText: "Value"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Value girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _voltageController,
                  decoration: InputDecoration(labelText: "Voltage"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Voltage başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _wattController,
                  decoration: InputDecoration(labelText: "Watt"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Watt başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _toleransController,
                  decoration: InputDecoration(labelText: "Tolerans"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Tolerans başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _footPrintController,
                  decoration: InputDecoration(labelText: "Foot Print"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Foot Print başlığı girin';
                    }
                    return null;
                  },
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                if (_imageFiles.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _imageFiles.isNotEmpty) {
                      final int quantity =
                          int.tryParse(_quantityController.text) ?? 0;
                      context.read<StocktrackingBloc>().add(
                            AddCategoriesEvent(
                              categoryModel: StockTrackingModel(
                                footPrint: _footPrintController.text,
                                shelfNumber: _shelfNumberController.text,
                                tolerans: _toleransController.text,
                                valueE: _valueEController.text,
                                voltage: _voltageController.text,
                                watt: _wattController.text,
                                quantity: quantity,
                                image: null,
                                title: _titleController.text,
                                stockId: _idController.text,
                              ),
                              imageFile: _imageFiles[0],
                            ),
                          );
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
      ),
    );
  }
}
