import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// CartProductCard: kartu produk versi ringkas untuk halaman Cart.
class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Container: kartu putih pembungkus produk di keranjang.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      // BoxDecoration: warna, border, radius.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4E4FC),
        ),
      ),
      // Row: gambar produk (kiri) + informasi (tengah) + jumlah (kanan).
      child: Row(
        children: [
          // Image.asset: menampilkan gambar produk dari folder assets.
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/product_1.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              // errorBuilder: fallback jika gambar belum tersedia.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: const Color(0xFFD4E4FC),
                  child: const Icon(
                    Icons.science_rounded,
                    color: Color(0xFF1960A3),
                    size: 32,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 14),

          // Expanded: informasi produk mengisi sisa ruang.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text: nama produk.
                const Text(
                  'Gelas Erlenmeyer 250ml',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1F),
                  ),
                ),
                const SizedBox(height: 2),
                // Text: deskripsi singkat.
                const Text(
                  'Borosilikat 3.3',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF44474C),
                  ),
                ),
                const SizedBox(height: 6),
                // Text: harga produk.
                const Text(
                  'Rp85.000',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1960A3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // TextField: input jumlah produk (hanya angka).
          // keyboardType: number agar muncul keyboard angka.
          // FilteringTextInputFormatter.digitsOnly: hanya menerima digit.
          SizedBox(
            width: 52,
            height: 44,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '1',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF44474C),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4E4FC),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4E4FC),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}