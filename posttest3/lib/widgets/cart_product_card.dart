import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product.dart';

// CartProductCard: kartu produk versi ringkas untuk halaman Cart.
// Diubah jadi StatefulWidget karena punya TextEditingController
class CartProductCard extends StatefulWidget {
  const CartProductCard({
    required this.product,
    required this.quantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
    required this.onRemove,
    super.key,
  });

  // product: data produk yang ditampilkan.
  final Product product;
  // quantity: jumlah produk di keranjang (dari parent).
  final int quantity;
  // maxQuantity: batas maksimal quantity (quantity + stock sisa).
  final int maxQuantity;
  // onQuantityChanged: callback ke CartPage kalau quantity berubah.
  final ValueChanged<int> onQuantityChanged;
  // onRemove: callback ke CartPage kalau user klik tombol hapus.
  final VoidCallback onRemove;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  // quantityController: controller untuk TextField jumlah.
  // late final: diinisialisasi di initState.
  late final TextEditingController quantityController;

  @override
  void initState() {
    // initState: dipanggil sekali saat widget pertama kali dibuat.
    super.initState();
    quantityController = TextEditingController(text: '${widget.quantity}');
  }

  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    // didUpdateWidget: dipanggil saat parent rebuild & widget ini dapat
    // prop baru. Dipakai untuk sinkronkan TextField kalau quantity
    // berubah dari luar (misal dari halaman lain).
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}';
    }
  }

  @override
  void dispose() {
    // dispose: dipanggil saat widget dihapus. Controller harus di-dispose
    // biar gak memory leak.
    quantityController.dispose();
    super.dispose();
  }

  // updateQuantity: validasi input user di TextField.
  // - parse ke int, kalau bukan angka atau < 1, abaikan.
  // - kalau valid, clamp antara 1 dan maxQuantity, lalu kirim ke parent.
  void updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    widget.onQuantityChanged(parsed.clamp(1, widget.maxQuantity));
  }

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
        border: Border.all(color: const Color(0xFFD4E4FC)),
      ),
      // Row: gambar produk (kiri) + informasi (tengah) + jumlah & hapus (kanan).
      child: Row(
        children: [
          // Image.asset: menampilkan gambar produk dari folder assets.
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              widget.product.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              // errorBuilder: fallback jika gambar belum tersedia.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: const Color(0xFFD4E4FC),
                  child: Icon(
                    widget.product.icon,
                    color: const Color(0xFF1960A3),
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
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181C1F),
                  ),
                ),
                const SizedBox(height: 2),
                // Text: deskripsi singkat.
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF44474C),
                  ),
                ),
                const SizedBox(height: 6),
                // Text: harga produk.
                Text(
                  formatRupiah(widget.product.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1960A3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Row: tombol hapus (kiri) + TextField jumlah (kanan).
          Row(
            children: [
              // GestureDetector: tombol hapus item dari keranjang.
              GestureDetector(
                onTap: widget.onRemove,
                child: Container(
                  width: 36,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFDAD6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Icon: ikon tempat sampah.
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFBA1A1A),
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // TextField: input jumlah produk (hanya angka).
              // controller: pakai quantityController biar bisa disinkronkan.
              // keyboardType: number agar muncul keyboard angka.
              // FilteringTextInputFormatter.digitsOnly: hanya menerima digit.
              SizedBox(
                width: 52,
                height: 44,
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  onChanged: updateQuantity,
                  decoration: InputDecoration(
                    hintText: '1',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF44474C),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD4E4FC)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD4E4FC)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
