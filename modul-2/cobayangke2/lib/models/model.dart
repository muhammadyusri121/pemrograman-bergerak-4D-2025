// models/wisata_model.dart
class WisataModel {
  final String id;
  final String nama;
  final String lokasi;
  final String jenis;
  final double harga;
  final String deskripsi;
  final String imagePath;
  
  WisataModel({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
    required this.imagePath,
  });
  
  // Konversi dari Map (untuk database)
  factory WisataModel.fromMap(Map<String, dynamic> map) {
    return WisataModel(
      id: map['id'],
      nama: map['nama'],
      lokasi: map['lokasi'],
      jenis: map['jenis'],
      harga: map['harga'].toDouble(),
      deskripsi: map['deskripsi'],
      imagePath: map['imagePath'],
    );
  }
  
  // Konversi ke Map (untuk database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'lokasi': lokasi,
      'jenis': jenis,
      'harga': harga,
      'deskripsi': deskripsi,
      'imagePath': imagePath,
    };
  }
}