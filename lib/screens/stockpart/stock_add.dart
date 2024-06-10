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
  final TextEditingController _currentController = TextEditingController();

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
        elevation: 1.0,
        title: Text("Stok Ekle"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: "Stok Başlığı",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Stok Başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Stok Adedi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Stok Adedi girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _shelfNumberController,
                  decoration: InputDecoration(
                      labelText: "Raf Numarası",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Raf Numanası girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _valueEController,
                  decoration: InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Value girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _voltageController,
                  decoration: InputDecoration(
                      labelText: "Voltage",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Voltage başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _wattController,
                  decoration: InputDecoration(
                      labelText: "Watt",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Watt başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _toleransController,
                  decoration: InputDecoration(
                      labelText: "Tolerans",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Tolerans başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _footPrintController,
                  decoration: InputDecoration(
                      labelText: "Foot Print",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Foot Print başlığı girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _currentController,
                  decoration: InputDecoration(
                      labelText: "Current",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.all(18)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir Current girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.30,
                            MediaQuery.of(context).size.height * 0.06),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          width: MediaQuery.of(context).size.width * 0.003,
                          color: Colors.black, // Çerçeve rengi
                        ),
                      ),
                      elevation: const MaterialStatePropertyAll(5)),
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text(
                    'Kameradan Fotoğraf Yükle',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.30,
                            MediaQuery.of(context).size.height * 0.06),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          width: MediaQuery.of(context).size.width * 0.003,
                          color: Colors.black, // Çerçeve rengi
                        ),
                      ),
                      elevation: const MaterialStatePropertyAll(5)),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text(
                    'Galeriden Fotoğraf Yükle',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                if (_imageFiles.isNotEmpty)
                  SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      _imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.30,
                            MediaQuery.of(context).size.height * 0.06),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          width: MediaQuery.of(context).size.width * 0.003,
                          color: Colors.black, // Çerçeve rengi
                        ),
                      ),
                      elevation: const MaterialStatePropertyAll(5)),
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
                                current: _currentController.text,
                              ),
                              imageFile: _imageFiles[0],
                            ),
                          );
                      context.read<StocktrackingBloc>().add(ResetEvent());
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Kaydet',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
