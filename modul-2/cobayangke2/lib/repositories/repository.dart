// repositories/wisata_repository.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/model.dart';

class WisataRepository extends ChangeNotifier {
  // Simpan data dalam memory (untuk contoh)

  final List<WisataModel> _wisataList = [];
  
  // Getter untuk mendapatkan semua data wisata
  List<WisataModel> get wisataList => _wisataList;
  
  // Getter untuk mendapatkan wisata terbaik (contoh: 5 teratas)
  List<WisataModel> get bestWisata {
    // Contoh: ambil 5 data teratas atau semua jika kurang dari 5
    final count = _wisataList.length > 5 ? 5 : _wisataList.length;
    return _wisataList.sublist(0, count);
  }
  
  // Menambahkan data wisata baru
  void addWisata(WisataModel wisata) {
    _wisataList.add(wisata);
    notifyListeners(); // Memberitahu widget yang menggunakan data ini untuk rebuild
  }
  
  // Membuat wisata baru dari form input
  WisataModel createWisata({
    required String nama,
    required String lokasi,
    required String jenis,
    required String harga,
    required String deskripsi,
    required String imagePath,
  }) {
    // Generate ID unik
    final id = 'wisata_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
    
    // Buat objek wisata baru
    final wisata = WisataModel(
      id: id,
      nama: nama,
      lokasi: lokasi,
      jenis: jenis,
      harga: double.tryParse(harga) ?? 0.0,
      deskripsi: deskripsi,
      imagePath: imagePath,
    );
    
    // Tambahkan ke repository
    addWisata(wisata);
    
    return wisata;
  }
  
  // Mendapatkan wisata berdasarkan ID
  WisataModel? getWisataById(String id) {
    try {
      return _wisataList.firstWhere((wisata) => wisata.id == id);
    } catch (e) {
      return null;
    }
  }
}