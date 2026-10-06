import 'package:flutter/material.dart';

import 'models/product.dart';

// TotalPage: halaman sukses setelah checkout.
// Stateless karena cuma nampilkan grandTotal yang dikirim dari CartPage.
class TotalPage extends StatelessWidget {
  const TotalPage({required this.grandTotal, super.key});

  // grandTotal: total harga yang dibayar (dari state MainApp).
  final int grandTotal;

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman.
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),
      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // Center: konten di tengah layar.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          // Column: susun ikon, teks, total, tombol vertikal.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container: lingkaran navy ikon centang.
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF0F1C2C),
                  shape: BoxShape.circle,
                ),
                // Icon: ikon centang putih.
                child: const Icon(Icons.check, color: Colors.white, size: 70),
              ),
              const SizedBox(height: 32),
              // Text: judul sukses.
              const Text(
                'Checkout Berhasil!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181C1F),
                ),
              ),
              const SizedBox(height: 8),
              // Text: keterangan tambahan.
              const Text(
                'Terima kasih sudah berbelanja di Labora.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF44474C)),
              ),
              const SizedBox(height: 26),
              // Text: label total.
              const Text(
                'Total Pembayaran',
                style: TextStyle(fontSize: 13, color: Color(0xFF44474C)),
              ),
              const SizedBox(height: 6),
              // Text: nilai total (format Rupiah).
              Text(
                formatRupiah(grandTotal),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1960A3),
                ),
              ),
              const SizedBox(height: 34),
              // SizedBox: lebar penuh untuk tombol.
              SizedBox(
                width: double.infinity,
                height: 48,
                // ElevatedButton: tombol kembali.
                // Navigator.pop: balik ke CartPage.
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F1C2C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  // Row: ikon + label tombol.
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_rounded, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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