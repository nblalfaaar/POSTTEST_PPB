import 'package:flutter/material.dart';

import 'profile_page.dart';

// CategoryPage: halaman daftar kategori alat laboratorium.
// Diubah jadi StatefulWidget karena punya state searchQuery
// yang berubah saat user mengetik di search bar.
class CategoryPage extends StatefulWidget {
  const CategoryPage({required this.onOpenCart, super.key});

  final VoidCallback onOpenCart;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // searchQuery: state untuk filter kategori.
  String searchQuery = '';

  // Data dummy kategori.
  final List<Map<String, dynamic>> categories = const [
    {
      'label': 'Gelas Kimia',
      'desc': 'Erlenmeyer, beaker, labu ukur',
      'icon': Icons.science_outlined,
    },
    {
      'label': 'Mikroskop',
      'desc': 'Binokular, monokular, digital',
      'icon': Icons.biotech_outlined,
    },
    {
      'label': 'APD',
      'desc': 'Jas lab, sarung tangan, masker',
      'icon': Icons.masks_outlined,
    },
    {
      'label': 'Reagen',
      'desc': 'Bahan kimia & larutan',
      'icon': Icons.opacity_outlined,
    },
    {
      'label': 'Instrumen Ukur',
      'desc': 'Pipet, buret, timbangan',
      'icon': Icons.straighten_outlined,
    },
    {
      'label': 'Penyimpanan',
      'desc': 'Rak, desikator, lemari asam',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // filteredCategories: kategori yang cocok searchQuery.
    final filteredCategories = categories.where((cat) {
      return (cat['label'] as String).toLowerCase().contains(searchQuery) ||
          (cat['desc'] as String).toLowerCase().contains(searchQuery);
    }).toList();

    // Scaffold: struktur dasar halaman.
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),

      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // Column: susun header + search + list kategori vertikal.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding: jarak header dari tepi layar.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              // Row: tombol back + judul.
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
                    'Kategori Alat Lab',
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
                  hintText: 'Cari kategori...',
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

            // Expanded: list kategori mengisi sisa ruang.
            Expanded(
              // SingleChildScrollView: list bisa di-scroll.
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // Column: susun kartu kategori vertikal.
                  child: Column(
                    children: filteredCategories.map((cat) {
                      // Padding: jarak bawah antar kartu.
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        // Container: kartu kategori.
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFD4E4FC)),
                            // BoxShadow: bayangan halus pada kartu.
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          // Row: ikon (kiri) + teks (tengah) + panah (kanan).
                          child: Row(
                            children: [
                              // Container: lingkaran biru muda ikon kategori.
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4E4FC),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                // Icon: simbol kategori.
                                child: Icon(
                                  cat['icon'] as IconData,
                                  color: const Color(0xFF1960A3),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              // Expanded: teks kategori.
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text: nama kategori.
                                    Text(
                                      cat['label'] as String,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF181C1F),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    // Text: deskripsi kategori.
                                    Text(
                                      cat['desc'] as String,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF44474C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Icon: panah ke kanan.
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF1960A3),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: navigasi bawah dengan gaya pil navy
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
              // Kategori: menu aktif
              _navItem(Icons.biotech_rounded, 'Kategori', true, () {}),
              _navItem(Icons.inventory_2_outlined, 'Pesanan', false, () {
                widget.onOpenCart();
              }),
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
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
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