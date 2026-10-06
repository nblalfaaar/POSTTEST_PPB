import 'package:flutter/material.dart';

import 'category_page.dart';
import 'models/product.dart';
import 'profile_page.dart';
import 'widgets/cart_product_card.dart';

// CartPage: halaman keranjang belanja.
// Diubah jadi StatefulWidget karena punya state searchQuery
// yang berubah saat user mengetik di search bar.
class CartPage extends StatefulWidget {
  const CartPage({
    required this.products,
    required this.cartQuantities,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onCheckout,
    required this.onOpenCart,
    super.key,
  });

  // products: daftar semua produk (buat lookup nama & harga).
  final List<Product> products;
  // cartQuantities: map id produk -> jumlah di keranjang.
  final Map<String, int> cartQuantities;
  // onQuantityChanged: callback ke MainApp kalau quantity berubah.
  final void Function(Product product, int quantity) onQuantityChanged;
  // onRemove: callback ke MainApp kalau user hapus produk dari keranjang.
  final ValueChanged<Product> onRemove;
  // onCheckout: callback ke MainApp kalau tombol checkout ditekan.
  final VoidCallback onCheckout;
  // onOpenCart: callback untuk balik ke CartPage (dipakai dari CategoryPage/ProfilePage).
  final VoidCallback onOpenCart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // searchQuery: state untuk filter produk di keranjang.
  String searchQuery = '';

  // currentGrandTotal: hitung total harga produk yang ada di keranjang.
  int get currentGrandTotal => widget.products.fold(0, (total, product) {
    return total + product.price * (widget.cartQuantities[product.id] ?? 0);
  });

  @override
  Widget build(BuildContext context) {
    // cartProducts: produk yang ada di keranjang & cocok search.
    // Syarat: quantity > 0 dan nama mengandung searchQuery.
    final cartProducts = widget.products.where((product) {
      return (widget.cartQuantities[product.id] ?? 0) > 0 &&
          product.name.toLowerCase().contains(searchQuery);
    }).toList();

    // Scaffold: struktur dasar halaman.
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),

      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // Column: susun search bar (atas) + list & total (bawah) vertikal.
        child: Column(
          children: [
            // Padding: jarak search bar dari tepi layar.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              // Row: tombol back (kiri) + judul (tengah) + placeholder (kanan).
              child: Row(
                children: [
                  // GestureDetector: tombol back.
                  // Navigator.pop: kembali ke halaman sebelumnya.
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD4E4FC)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF0F1C2C),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text: judul halaman.
                  const Text(
                    'Keranjang Saya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF181C1F),
                    ),
                  ),
                ],
              ),
            ),

            // Search bar: TextField dengan border rounded.
            // onChanged: tiap user ngetik, update searchQuery lewat setState.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) =>
                    setState(() => searchQuery = value.toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Cari di keranjang...',
                  hintStyle: const TextStyle(
                    color: Color(0xB344474C),
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF44474C),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFD4E4FC)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFD4E4FC)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Expanded: area list produk & total mengisi sisa ruang.
            Expanded(
              // Stack: menumpuk list produk & bar total di bawah.
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // SingleChildScrollView: list produk bisa di-scroll.
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                      // Column: susun kartu produk vertikal.
                      child: Column(
                        children: [
                          // Cek: kalau keranjang kosong, tampilkan teks
                          if (cartProducts.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 80),
                              // Column: susun ikon + teks vertikal.
                              child: Column(
                                children: [
                                  // Icon: ikon keranjang kosong (kecil aja).
                                  const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Color(0xFFD4E4FC),
                                    size: 64,
                                  ),
                                  const SizedBox(height: 12),
                                  // Text: judul empty state.
                                  const Text(
                                    'Keranjang Masih Kosong',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181C1F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Text: keterangan tambahan.
                                  const Text(
                                    'Tambahkan produk dulu untuk checkout.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF44474C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          for (
                            var index = 0;
                            index < cartProducts.length;
                            index++
                          ) ...[
                            CartProductCard(
                              product: cartProducts[index],
                              quantity: widget
                                  .cartQuantities[cartProducts[index].id]!,
                              maxQuantity:
                                  widget.cartQuantities[cartProducts[index]
                                      .id]! +
                                  cartProducts[index].stock,
                              onQuantityChanged: (quantity) {
                                widget.onQuantityChanged(
                                  cartProducts[index],
                                  quantity,
                                );
                                setState(() {});
                              },
                              // onRemove: hapus produk dari keranjang,
                              onRemove: () {
                                widget.onRemove(cartProducts[index]);
                                setState(() {});
                              },
                            ),
                            if (index < cartProducts.length - 1)
                              const SizedBox(height: 14),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Positioned: bar total & tombol di bawah layar.
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    // Container: bar total dengan shadow.
                    child: Container(
                      // width: double.infinity biar lebar penuh.
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // BoxShadow: bayangan di atas bar total.
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      // Row: total (kiri) + tombol (kanan).
                      child: Row(
                        // mainAxisAlignment: kasih jarak antar ujung.
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Expanded: kolom total.
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Text: label total.
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF44474C),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Text: nilai total (di-format Rupiah).
                                Text(
                                  formatRupiah(currentGrandTotal),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF181C1F),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // SizedBox: tombol checkout ukuran tetap.
                          SizedBox(
                            width: 160,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: currentGrandTotal > 0
                                  ? widget.onCheckout
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F1C2C),
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: const Color(
                                  0xFFD4E4FC,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              // Row: ikon + label tombol.
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shopping_cart_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 13,
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
                ],
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: navigasi bawah dengan gaya pil navy.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        // Container: pil navy pembungkus menu navigasi
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1C2C),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0x661960A3)),
          ),
          // Row: 4 menu navigasi horizontal
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Beranda: Navigator.pop kembali ke HomePage
              _navItem(Icons.home_rounded, 'Beranda', false, () {
                Navigator.pop(context);
              }),
              _navItem(Icons.biotech_rounded, 'Kategori', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryPage(onOpenCart: widget.onOpenCart),
                  ),
                );
              }),
              // Pesanan: menu aktif
              _navItem(Icons.inventory_2_outlined, 'Pesanan', true, () {}),
              _navItem(Icons.person_outline_rounded, 'Profil', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(onOpenCart: widget.onOpenCart),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Item navigasi bawah
  Widget _navItem(
    IconData icon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    // ElevatedButton: tombol menu navigasi dengan style transparan
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero, // padding: hilangkan padding bawaan
        minimumSize: Size.zero, // minimumSize: kecilkan ukuran minimum
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      // Container: pil latar untuk menu aktif
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0x267DB6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        // Column: ikon di atas label
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon: ikon menu
            Icon(
              icon,
              color: active ? const Color(0xFF7DB6FF) : const Color(0x99FFFFFF),
              size: 20,
            ),
            const SizedBox(height: 3),
            // Text: nama menu
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: active
                    ? const Color(0xFF7DB6FF)
                    : const Color(0x99FFFFFF),
                fontWeight: active ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
