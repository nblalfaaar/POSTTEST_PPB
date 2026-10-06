import 'package:flutter/material.dart';

import '../models/product.dart';

// ProductCard: satu kartu produk untuk ditampilkan di HomePage.
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onAddToCart,
    super.key,
  });

  // product: data produk yang ditampilkan.
  final Product product;
  // onAddToCart: callback ke HomePage saat tombol "Tambah" ditekan.
  final VoidCallback onAddToCart;

  static const Color navy = Color(0xFF0F1C2C);
  static const Color blue = Color(0xFF1960A3);
  static const Color lightBlue = Color(0xFFD4E4FC);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF181C1F);
  static const Color textGrey = Color(0xFF44474C);

  static const Color navy85 = Color(0xD90F1C2C);
  static const Color white90 = Color(0xE6FFFFFF);

  @override
  Widget build(BuildContext context) {
    // Container: kartu putih pembungkus produk
    return Container(
      // padding: jarak isi kartu dari tepi
      padding: const EdgeInsets.all(14),
      // BoxDecoration: warna, border, radius
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: lightBlue),
      ),
      // Column: susun area gambar (atas) & info (bawah) vertikal
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container: kotak biru muda tempat gambar produk
          Container(
            width: double.infinity,
            height: 160, // tinggi: 160 biar gambar lebih besar
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            // Stack: tumpuk gambar & badge jadi satu
            child: Stack(
              children: [
                // Positioned.fill: gambar isi seluruh kotak
                Positioned.fill(
                  // ClipRRect: potong gambar biar rapi
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    // Image.asset: menampilkan gambar produk dari folder assets
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.cover, // cover: gambar penuhi kotak
                      // errorBuilder: fallback kalau gambar belum ada
                      errorBuilder: (context, error, stackTrace) {
                        // Icon: fallback ikon labu
                        return Icon(product.icon, color: blue, size: 60);
                      },
                    ),
                  ),
                ),
                // Positioned: badge di kiri atas
                Positioned(
                  top: 10,
                  left: 10,
                  // Container: badge
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: navy85,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // Text: label badge
                    child: Text(
                      product.badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Positioned: tombol favorit di kanan atas
                Positioned(
                  top: 10,
                  right: 10,
                  // Container: tombol favorit bulat
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: white90,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    // Icon: ikon hati
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: textGrey,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox: jarak antara gambar & info
          const SizedBox(height: 12),

          // info produk
          // Row: info produk (kiri) + harga (kanan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded: kolom info isi sisa ruang
              Expanded(
                // Column: kategori, nama, deskripsi vertikal
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text: kategori produk
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
                    // Text: nama produk
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Text: deskripsi produk
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 11, color: textGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Column: harga + catatan stok vertikal
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text: harga (format Rupiah)
                  Text(
                    formatRupiah(product.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Text: catatan stok
                  Text(
                    'Stok ${product.stock}',
                    style: const TextStyle(fontSize: 10, color: blue),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // rating & tombol
          // Row: rating (kiri) + tombol (kanan)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row: bintang + rating + jumlah pesanan
              Row(
                children: [
                  // Icon: bintang rating
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFF5A623),
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  // Text: angka rating
                  Text(
                    '${product.rating}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(width: 3),
                  // Text: jumlah pesanan
                  Text(
                    '(${product.ratingCount} pesanan)',
                    style: const TextStyle(fontSize: 10, color: textGrey),
                  ),
                ],
              ),
              // ElevatedButton: tombol "Tambah"
              // onPressed: aktif kalau stock > 0, kalau habis null (nonaktif).
              ElevatedButton(
                onPressed: product.stock > 0 ? onAddToCart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy, // background: navy
                  foregroundColor: Colors.white, // foreground: putih
                  disabledBackgroundColor: lightBlue, // warna kalau nonaktif
                  elevation: 0, // elevation: rata
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ), // padding: jarak isi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // radius: 12
                  ),
                ),
                // Row: label + ikon keranjang
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text: label tombol
                    Text(
                      'Tambah',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    // Icon: ikon keranjang
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.white,
                      size: 15,
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
