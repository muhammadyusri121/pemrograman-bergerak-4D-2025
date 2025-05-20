import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  final String baseUrl =
      'https://firestore.googleapis.com/v1/projects/fir-praktikum-8055c/databases/(default)/documents';
  final String collectionPath = '/produk';

  // Get all products
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$collectionPath'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if documents exist
        if (!data.containsKey('documents')) {
          return [];
        }

        List<Product> products = [];
        for (var doc in data['documents']) {
          // Extract document ID from name field (last segment after last slash)
          String docId = doc['name'].split('/').last;
          products.add(Product.fromFirestore(doc, docId));
        }
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Get produk berdasarkan id
  Future<Product> getProduct(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$collectionPath/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromFirestore(data, id);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  // Tambah produk
  Future<String> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$collectionPath'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toFirestore()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Extract and return the new document ID
        return data['name'].split('/').last;
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  // Update produk
  Future<void> updateProduct(String id, Product product) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$collectionPath/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toFirestore()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Delete produk
  Future<void> deleteProduct(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$collectionPath/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
