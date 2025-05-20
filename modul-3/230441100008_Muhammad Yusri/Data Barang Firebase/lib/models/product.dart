class Product {
  String id;
  String namaProduk;
  String pemasokProduk;
  int jumlah;
  int harga;

  Product({
    required this.id,
    required this.namaProduk,
    required this.pemasokProduk,
    required this.jumlah,
    required this.harga,
  });

  // Convert Firestore REST API response to Product object
  factory Product.fromFirestore(Map<String, dynamic> doc, String docId) {
    return Product(
      id: docId,
      namaProduk: doc['fields']['NamaProduk']['stringValue'],
      pemasokProduk: doc['fields']['PemasokProduk']['stringValue'],
      jumlah: int.parse(doc['fields']['Jumlah']['integerValue'].toString()),
      harga: int.parse(doc['fields']['Harga']['integerValue'].toString()),
    );
  }

  // Convert Product object to Firestore REST API format
  Map<String, dynamic> toFirestore() {
    return {
      'fields': {
        'NamaProduk': {
          'stringValue': namaProduk,
        },
        'PemasokProduk': {
          'stringValue': pemasokProduk,
        },
        'Jumlah': {
          'integerValue': jumlah,
        },
        'Harga': {
          'integerValue': harga,
        },
      }
    };
  }
}
