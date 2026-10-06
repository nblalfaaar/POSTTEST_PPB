import 'package:flutter/material.dart';

// Product: model data produk alat lab.
// Dibuat class tersendiri agar bisa dipakai di banyak halaman.
class Product {
  // constructor: menerima seluruh data produk.
  Product({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.badge,
    required this.rating,
    required this.ratingCount,
    required this.icon,
  });

  // id: identitas unik produk (dipakai untuk key di cartQuantities).
  final String id;
  // imagePath: path gambar produk di folder assets.
  final String imagePath;
  // name: nama produk.
  final String name;
  // category: kategori produk (misal "PERALATAN GELAS").
  final String category;
  // description: deskripsi singkat produk.
  final String description;
  // price: harga produk dalam satuan int (biar bisa dihitung).
  final int price;
  // stock: jumlah stok produk. Tidak final karena bisa berubah.
  int stock;
  // badge: label kecil di atas gambar produk.
  final String badge;
  // rating: nilai rating produk.
  final double rating;
  // ratingCount: jumlah orang yang sudah pesan.
  final int ratingCount;
  // icon: ikon fallback kalau gambar belum tersedia.
  final IconData icon;
}

// formatRupiah: function untuk mengubah int jadi format "Rp85.000".
String formatRupiah(int value) {
  final digits = value.toString();
  final groups = <String>[];
  for (var end = digits.length; end > 0; end -= 3) {
    final start = end - 3 < 0 ? 0 : end - 3;
    groups.insert(0, digits.substring(start, end));
  }
  return 'Rp${groups.join('.')}';
}
