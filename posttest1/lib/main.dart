import 'package:flutter/material.dart';

import 'widgets/product_card.dart';

void main() {
  runApp(const LaboraApp());
}

// warna warna tema aplikasi (biru biru).
class AppColors {
  static const Color navy = Color(0xFF0F1C2C);
  static const Color blue = Color(0xFF1960A3);
  static const Color lightBlue = Color(0xFFD4E4FC);
  static const Color background = Color(0xFFF7FAFE);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF181C1F);
  static const Color textGrey = Color(0xFF44474C);
  static const Color error = Color(0xFFBA1A1A);

  // untuk warna transparan
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color accentLight = Color(0xFF7DB6FF);
  static const Color accentLight18 = Color(0x2E7DB6FF);
  static const Color accentLight15 = Color(0x267DB6FF);
  static const Color lightBlue50 = Color(0x80D4E4FC);
  static const Color textGrey70 = Color(0xB344474C);
  static const Color blue40 = Color(0x661960A3);
  static const Color blue20 = Color(0x1F1960A3);
}

// Class untuk item kategori.
class CategoryItem {
  final String label;
  final IconData icon;

  const CategoryItem({
    required this.label,
    required this.icon,
  });
}

class LaboraApp extends StatelessWidget {
  const LaboraApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: untuk wrapper utama aplikasi (tema global & halaman awal).
    return MaterialApp(
      title: 'Labora',    // title: nama aplikasi.
      debugShowCheckedModeBanner: false,    // debugShowCheckedModeBanner: matikan pita debug.
      // theme: aturan visual umum aplikasi.
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',    // fontnya
        scaffoldBackgroundColor: AppColors.background,    // warna bg kerangkanya
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy),   // bikin skema warna otomatis
      ),
      home: HomePage(),   // home: halaman pertama yang tampil.
    );
  }
}

// HomePage: halaman utama aplikasi Labora.
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Data dummy kategori alat lab.
  final List<CategoryItem> categories = [
    CategoryItem(label: 'Gelas Kimia', icon: Icons.science_outlined),
    CategoryItem(label: 'Mikroskop', icon: Icons.biotech_outlined),
    CategoryItem(label: 'APD', icon: Icons.masks_outlined),
    CategoryItem(label: 'Reagen', icon: Icons.opacity_outlined),
  ];

  // Data dummy produk populer.
  final List<LabProduct> products = [
    LabProduct(
      badge: 'Aman Autoklaf',
      category: 'PERALATAN GELAS',
      name: 'Gelas Erlenmeyer 250ml',
      description: 'Borosilikat 3.3 • Tahan panas tinggi',
      price: 'Rp85.000',
      note: 'Stok 120 unit',
      rating: 4.9,
      ratingCount: 118,
      icon: Icons.science,
    ),
    LabProduct(
      badge: 'Bergaransi 2 Tahun',
      category: 'INSTRUMEN OPTIK',
      name: 'Mikroskop Binokular XT-200',
      description: 'Perbesaran 40x-1000x • Lensa presisi',
      price: 'Rp4.250.000',
      note: 'Pengiriman gratis',
      rating: 4.8,
      ratingCount: 94,
      icon: Icons.biotech,
    ),
    LabProduct(
      badge: 'Sertifikasi SNI',
      category: 'ALAT PELINDUNG DIRI',
      name: 'Jas Lab Anti Asam',
      description: 'Bahan anti tembus cairan kimia',
      price: 'Rp150.000',
      note: 'Ready stock',
      rating: 4.7,
      ratingCount: 63,
      icon: Icons.checkroom,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman (body + bottomNavigationBar).
    return Scaffold(
      backgroundColor: AppColors.background,      // backgroundColor: warna latar halaman.
      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // SingleChildScrollView: agar halaman bisa di-scroll.
        child: SingleChildScrollView(
          // Column: susun hero & konten vertikal.
          child: Column(
            children: [
              _buildHeroSection(),
              // Padding: jarak konten dari tepi layar.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                // Column: susun seluruh section vertikal.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromoBanner(),
                    // SizedBox: jarak antar section.
                    const SizedBox(height: 24),
                    _buildSectionTitle('Kategori Alat Lab', showAction: true),
                    const SizedBox(height: 14),
                    _buildCategoryRow(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Produk Populer', showAction: false),
                    const SizedBox(height: 14),
                    _buildProductList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: navigasi bawah
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // hero
  Widget _buildHeroSection() {
    // Container: latar navy besar di atas halaman.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      // BoxDecoration: warna & radius.
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      // Column: susun profil, judul, search bar vertikal.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: profil (kiri) & notifikasi (kanan).
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Container: avatar bulat.
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    // Icon: ikon pengguna.
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Column: label & nama vertikal.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text: label status.
                      const Text(
                        'PELANGGAN TERVERIFIKASI',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: AppColors.white60,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          // Text: nama pengguna.
                          Text(
                            'Nabilah Alfa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          // Icon: simbol terverifikasi.
                          Icon(
                            Icons.verified_rounded,
                            color: AppColors.accentLight,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Container: tombol bulat notifikasi.
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.white12,
                  borderRadius: BorderRadius.circular(999),
                ),
                // Row: ikon lonceng + titik merah.
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon: ikon lonceng.
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    // Container: titik merah notifikasi.
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          // Text: judul hero 1.
          const Text(
            'Temukan Kebutuhan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text: judul hero 2.
          const Text(
            'Laboratorium Anda',
            style: TextStyle(
              color: AppColors.accentLight,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _buildSearchBar(),
        ],
      ),
    );
  }

  // search bar
  Widget _buildSearchBar() {
    // Container: bungkus seluruh search bar.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      // Row: ikon kaca pembesar + TextField + tombol filter.
      child: Row(
        children: [
          // Icon: ikon kaca pembesar.
          const Icon(Icons.search_rounded, color: AppColors.textGrey, size: 20),
          const SizedBox(width: 10),
          // Expanded: TextField mengisi sisa ruang.
          Expanded(
            // TextField: input pencarian
            child: TextField(
              // InputDecoration: hanya hint & border none
              decoration: InputDecoration(
                hintText: 'Cari alat, bahan, atau reagen...',    // seperti placeholder
                hintStyle: const TextStyle(
                  color: AppColors.textGrey70,
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          // Container: tombol filter kotak navy.
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(12),
            ),
            // Icon: ikon filter.
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // promo
  Widget _buildPromoBanner() {
    // Container: kartu promo utama.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(28),
      ),
      // Row: teks promo (kiri) + ikon (kanan).
      child: Row(
        children: [
          // Expanded: teks promo isi sisa ruang.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    // Icon: titik penanda promo.
                    Icon(Icons.circle, color: AppColors.accentLight, size: 8),
                    SizedBox(width: 6),
                    // Text: label promo.
                    Text(
                      'PROMO AKTIF',
                      style: TextStyle(
                        color: AppColors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Text: judul promo.
                const Text(
                  'Diskon 20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Text: deskripsi promo.
                const Text(
                  'Untuk semua alat gelas laboratorium\nminggu ini saja.',
                  style: TextStyle(color: AppColors.white70, fontSize: 12),
                ),
                const SizedBox(height: 14),
                // Container: pil info batas waktu.
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      // Icon: ikon jam.
                      Icon(
                        Icons.schedule_rounded,
                        color: AppColors.accentLight,
                        size: 13,
                      ),
                      SizedBox(width: 6),
                      // Text: keterangan waktu.
                      Text(
                        'Berlaku hingga akhir minggu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Container: kotak bulat ikon labu.
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: AppColors.accentLight18,
              borderRadius: BorderRadius.circular(20),
            ),
            // Icon: ilustrasi labu.
            child: const Icon(
              Icons.science_rounded,
              color: AppColors.accentLight,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }

  // judul
  Widget _buildSectionTitle(String title, {required bool showAction}) {
    // Row: judul (kiri) + "Lihat Semua" (kanan).
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text: judul section.
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        showAction
            ? Row(
                children: const [
                  // Text: tautan lihat semua.
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Icon: panah.
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.blue,
                    size: 16,
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  // kategori
  Widget _buildCategoryRow() {
    // list penampung widget kategori
    List<Widget> items = [];

    // loop kategori
    for (int i = 0; i < categories.length; i++) {
      CategoryItem cat = categories[i];

      // Column -> ikon di atas label.
      items.add(
        Column(
          children: [
            // Container: lingkaran biru muda ikon kategori.
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(999),
              ),
              // Icon: simbol kategori.
              child: Icon(
                cat.icon,
                color: AppColors.blue,
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            // Text: nama kategori.
            Text(
              cat.label,
              style: const TextStyle(fontSize: 11, color: AppColors.textDark),
            ),
          ],
        ),
      );
    }

    // Row: 4 kategori berjejer horizontal.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  // produk
  Widget _buildProductList() {
    // list penampung kartu produk
    List<Widget> items = [];

    // loop produk
    for (int i = 0; i < products.length; i++) {
      LabProduct product = products[i];

      // Padding: jarak bawah antar kartu.
      items.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: ProductCard(product: product),
        ),
      );
    }

    // Column: kartu produk vertikal.
    return Column(
      children: items,
    );
  }

  // bottom nav
  Widget _buildBottomNav() {
    // Padding: jarak nav dari tepi layar.
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      // Container: pil navy pembungkus menu navigasi.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.blue40),
        ),
        // Row: 4 menu navigasi horizontal.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_rounded, 'Beranda', true),
            _navItem(Icons.biotech_rounded, 'Kategori', false),
            _navItem(Icons.inventory_2_outlined, 'Pesanan', false),
            _navItem(Icons.person_outline_rounded, 'Profil', false),
          ],
        ),
      ),
    );
  }

  // Item navigasi bawah
  Widget _navItem(IconData icon, String label, bool active) {
    // Container: pil latar untuk menu aktif.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.accentLight15 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      // Column: ikon di atas label.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon: ikon menu.
          Icon(
            icon,
            color: active ? AppColors.accentLight : AppColors.white60,
            size: 20,
          ),
          const SizedBox(height: 3),
          // Text: nama menu.
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: active ? AppColors.accentLight : AppColors.white60,
              fontWeight: active ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}