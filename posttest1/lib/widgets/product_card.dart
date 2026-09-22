import 'package:flutter/material.dart';

// Model data dummy alat lab
class LabProduct {
  final String badge;
  final String category;
  final String name;
  final String description;
  final String price;
  final String note;
  final double rating;
  final int ratingCount;
  final IconData icon;

  const LabProduct({
    required this.badge,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.note,
    required this.rating,
    required this.ratingCount,
    required this.icon,
  });
}

// ProductCard: satu kartu produk.
class ProductCard extends StatelessWidget {
  final LabProduct product;

  const ProductCard({super.key, required this.product});

  static const Color navy = Color(0xFF0F1C2C);
  static const Color blue = Color(0xFF1960A3);
  static const Color lightBlue = Color(0xFFD4E4FC);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF181C1F);
  static const Color textGrey = Color(0xFF44474C);

  // Warna transparan manual.
  static const Color navy85 = Color(0xD90F1C2C);
  static const Color white90 = Color(0xE6FFFFFF);

  @override
  Widget build(BuildContext context) {
    // Container: kartu putih pembungkus produk.
    return Container(
      // padding: jarak isi kartu dari tepi.
      padding: const EdgeInsets.all(14),
      // BoxDecoration: warna, border, radius.
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: lightBlue),
      ),
      // Column: susun area gambar (atas) & info (bawah) vertikal.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container: kotak biru muda pengganti foto produk.
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            // Column: badge & favorit (atas) + ikon (tengah).
            child: Column(
              children: [
                // Padding: jarak badge dari tepi gambar.
                Padding(
                  padding: const EdgeInsets.all(10),
                  // Row: badge (kiri) + favorit (kanan).
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container: badge.
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: navy85,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // Text: label badge.
                        child: Text(
                          product.badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Container: tombol favorit bulat.
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: white90,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        // Icon: ikon hati.
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          color: textGrey,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded: ikon produk isi sisa ruang gambar.
                Expanded(
                  // Icon: ikon besar pengganti foto produk.
                  child: Icon(product.icon, color: blue, size: 52),
                ),
              ],
            ),
          ),
          // SizedBox: jarak antara gambar & info.
          const SizedBox(height: 12),

          // info produk
          // Row: info produk (kiri) + harga (kanan).
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded: kolom info isi sisa ruang.
              Expanded(
                // Column: kategori, nama, deskripsi vertikal.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text: kategori produk.
                    Text(
                      product.category,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: blue,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Text: nama produk.
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Text: deskripsi produk.
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 11, color: textGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Column: harga + catatan vertikal.
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text: harga.
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Text: catatan stok.
                  Text(
                    product.note,
                    style: const TextStyle(fontSize: 10, color: blue),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // rating & tombol
          // Row: rating (kiri) + tombol (kanan).
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row: bintang + rating + jumlah pesanan.
              Row(
                children: [
                  // Icon: bintang rating.
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFF5A623),
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  // Text: angka rating.
                  Text(
                    '${product.rating}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(width: 3),
                  // Text: jumlah pesanan.
                  Text(
                    '(${product.ratingCount} pesanan)',
                    style: const TextStyle(fontSize: 10, color: textGrey),
                  ),
                ],
              ),
              // Container: tombol "Tambah"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Row: label + ikon keranjang.
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text: label tombol.
                    Text(
                      'Tambah',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    // Icon: ikon keranjang.
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.white,
                      size: 13,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}