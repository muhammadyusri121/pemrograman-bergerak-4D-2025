// pages/form_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../repositories/repository.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  //contrller adalah objek yang digunakan untuk mengontrol inputan dari text field
  final TextEditingController namaWisataController = TextEditingController();
  // ini adalah controller untuk nama wisata, yang berfungsi untuk mengontrol inputan dari text field nama wisata
  final TextEditingController lokasiWisataController = TextEditingController();
  final TextEditingController hargaTiketController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // ini adalah controller untuk lokasi wisata, yang berfungsi untuk mengontrol inputan dari text field lokasi wisata
  String? _jenisWisata;
  File? _imageFile;

  final List<String> _jenisWisataOptions = [
    'Wisata Alam',
    'Wisata Budaya',
    'Wisata Kuliner',
    'Wisata Sejarah',
    'Wisata Religi',
  ];

  Future<void> _pickImage() async {
    // ini adalah fungsi untuk memilih gambar dari galeri
    // Menggunakan image_picker untuk memilih gambar dari galeri
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // jika gambar berhasil dipilih
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    // ini adalah fungsi untuk mengirimkan data form
    if (_formKey.currentState!.validate()) {
      // ini adah fungsi untuk memvalidasi form, jika valid maka akan mengirimkan data form
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan pilih gambar terlebih dahulu')),
        );
        return;
      }

      // Dapatkan repository
      final repository = Provider.of<WisataRepository>(context, listen: false);

      // Buat wisata baru
      repository.createWisata(
        nama: namaWisataController.text,
        lokasi: lokasiWisataController.text,
        jenis: _jenisWisata ?? 'Tidak Dikategorikan',
        harga: hargaTiketController.text,
        deskripsi: deskripsiController.text,
        imagePath: _imageFile!.path,
      );

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data wisata berhasil disimpan')),
      );

      // Kembali ke halaman home
      Navigator.of(context).pop();
    }
  }

  void _resetForm() {
    setState(() {
      namaWisataController.clear();
      lokasiWisataController.clear();
      hargaTiketController.clear();
      deskripsiController.clear();
      _jenisWisata = null;
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Tambah Wisata',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _imageFile != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        )
                        : const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
              ),
              const SizedBox(height: 10),

              // Upload Image Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3030C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nama Wisata
              const Text(
                'Nama Wisata :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: namaWisataController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama Wisata Disini',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lokasi wisata tidak boleh kosong';
                  }

                  // Memeriksa hanya huruf (termasuk beraksen) dan spasi
                  if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(value)) {
                    return 'Lokasi wisata hanya boleh berisi huruf dan spasi';
                  }

                  return null; // input valid
                },
              ),
              const SizedBox(height: 16),

              // Lokasi Wisata
              const Text(
                'Lokasi Wisata :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: lokasiWisataController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Lokasi Wisata Disini',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lokasi wisata tidak boleh kosong';
                  }

                  // Memeriksa hanya huruf (termasuk beraksen) dan spasi
                  if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(value)) {
                    return 'Lokasi wisata hanya boleh berisi huruf dan spasi';
                  }

                  return null; // input valid
                },
              ),
              const SizedBox(height: 16),

              // Jenis Wisata
              const Text(
                'Jenis Wisata :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: _jenisWisata,
                  hint: Text(
                    'Pilih Jenis Wisata',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                  items:
                      _jenisWisataOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _jenisWisata = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis wisata harus dipilih';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Harga Tiket
              const Text(
                'Harga Tiket :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: hargaTiketController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Masukkan Harga Tiket Disini',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tiket tidak boleh kosong';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Harga tiket harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Deskripsi
              const Text(
                'Deskripsi :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Masukkan Deskripsi Disini',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Simpan Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3030C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Reset Button
              Center(
                child: TextButton(
                  onPressed: _resetForm,
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
