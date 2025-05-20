import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductService _productService = ProductService();

  final _namaProdukController = TextEditingController();
  final _pemasokProdukController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();

  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.product != null;

    if (_isEditing) {
      _namaProdukController.text = widget.product!.namaProduk;
      _pemasokProdukController.text = widget.product!.pemasokProduk;
      _jumlahController.text = widget.product!.jumlah.toString();
      _hargaController.text = widget.product!.harga.toString();
    }
  }

  @override
  void dispose() {
    _namaProdukController.dispose();
    _pemasokProdukController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color.fromARGB(255, 226, 50, 50) : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final product = Product(
          id: _isEditing ? widget.product!.id : '',
          namaProduk: _namaProdukController.text,
          pemasokProduk: _pemasokProdukController.text,
          jumlah: int.parse(_jumlahController.text),
          harga: int.parse(_hargaController.text),
        );

        if (_isEditing) {
          await _productService.updateProduct(widget.product!.id, product);
          _showSnackBar('Produk berhasil diperbarui');
        } else {
          await _productService.addProduct(product);
          _showSnackBar('Produk berhasil ditambahkan');
        }

        Navigator.pop(context, true);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar(
          'Error: ${e.toString()}',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Produk' : 'Tambah Produk'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      controller: _namaProdukController,
                      label: 'Nama Produk',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Isi dulu dong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _pemasokProdukController,
                      label: 'Pemasok Produk',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'isi dulu bang';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _jumlahController,
                      label: 'Jumlah',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'gak boleh kosong yaa';
                        }
                        if (int.tryParse(value) == null) {
                          return 'jumlah itu angka woy';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _hargaController,
                      label: 'Harga',
                      // keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'isi ya sayang nanti kamu rugi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Harga harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _saveProduct,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _isEditing ? 'Update Produk' : 'Simpan Produk',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
