import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'models/product.dart';
import 'profile_page.dart';
import 'total_page.dart';
import 'widgets/product_card.dart';

// main: entry point aplikasi Flutter.
void main() {
  // runApp: menjalankan widget utama aplikasi.
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

  // constructor: menerima label & icon.
  const CategoryItem({required this.label, required this.icon});
}

// LaboraApp: root widget. Stateless karena cuma nyusun tema & halaman awal.
class LaboraApp extends StatelessWidget {
  const LaboraApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: untuk wrapper utama aplikasi (tema global & halaman awal).
    return MaterialApp(
      title: 'Labora', // title: nama aplikasi.
      debugShowCheckedModeBanner:
          false, // debugShowCheckedModeBanner: matikan pita debug.
      // theme: aturan visual umum aplikasi.
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans', // fontnya
        scaffoldBackgroundColor: AppColors.background, // warna bg kerangkanya
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.navy,
        ), // bikin skema warna otomatis
      ),
      home: HomePage(), // home: halaman pertama yang tampil.
    );
  }
}

// HomePage: halaman utama aplikasi Labora.
// Diubah jadi StatefulWidget karena punya state:
//  - searchQuery: kata kunci pencarian produk (berubah saat user ngetik).
//  - cartQuantities: map jumlah produk di keranjang (berubah saat add/kurang).
//  - products: daftar produk (stock bisa berubah).
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // searchQuery: state untuk filter produk berdasarkan nama (ini update tiap user ngetik di search bar).
  String searchQuery = '';

  // cartQuantities: state untuk menyimpan jumlah tiap produk di keranjang.
  // Key = id produk, Value = jumlah yang dipesan.
  // Kalau produk belum ada di map, artinya jumlahnya 0.
  final Map<String, int> cartQuantities = {};

  // Data dummy kategori alat lab.
  final List<CategoryItem> categories = [
    CategoryItem(label: 'Gelas Kimia', icon: Icons.science_outlined),
    CategoryItem(label: 'Mikroskop', icon: Icons.biotech_outlined),
    CategoryItem(label: 'APD', icon: Icons.masks_outlined),
    CategoryItem(label: 'Reagen', icon: Icons.opacity_outlined),
  ];

  // Data dummy produk populer.
  final List<Product> products = [
    Product(
      id: 'produk-1',
      badge: 'Aman Autoklaf',
      category: 'PERALATAN GELAS',
      name: 'Gelas Erlenmeyer 250ml',
      description: 'Borosilikat 3.3 • Tahan panas tinggi',
      price: 85000,
      stock: 120,
      rating: 4.9,
      ratingCount: 118,
      icon: Icons.science,
      imagePath: 'assets/product_1.png',
    ),
    Product(
      id: 'produk-2',
      badge: 'Bergaransi 2 Tahun',
      category: 'INSTRUMEN OPTIK',
      name: 'Mikroskop Binokular XT-200',
      description: 'Perbesaran 40x-1000x • Lensa presisi',
      price: 4250000,
      stock: 8,
      rating: 4.8,
      ratingCount: 94,
      icon: Icons.biotech,
      imagePath: 'assets/product_2.png',
    ),
    Product(
      id: 'produk-3',
      badge: 'Sertifikasi SNI',
      category: 'ALAT PELINDUNG DIRI',
      name: 'Jas Lab Anti Asam',
      description: 'Bahan anti tembus cairan kimia',
      price: 150000,
      stock: 35,
      rating: 4.7,
      ratingCount: 63,
      icon: Icons.checkroom,
      imagePath: 'assets/product_3.png',
    ),
  ];

  // addToCart: dipanggil saat tombol "Tambah" ditekan.
  // Fungsinya:
  //  - kurangi stock produk 1.
  //  - tambah quantity produk di keranjang 1.
  // Dibungkus setState karena mengubah state (UI ikut berubah).
  void addToCart(Product product) {
    if (product.stock == 0) return;
    setState(() {
      product.stock--;
      cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + 1;
    });
  }

  // changeQuantity: dipanggil saat quantity di CartProductCard berubah.
  // Fungsinya:
  //  - hitung quantity baru (di-clamp antara 1 sampai max).
  //  - sesuaikan stock (stock += selisih lama - baru).
  //  - simpan quantity baru ke cartQuantities.
  void changeQuantity(Product product, int quantity) {
    final currentQuantity = cartQuantities[product.id] ?? 0;
    // maxQuantity: jumlah sekarang + stock sisa (biar gak melebihi total).
    final maxQuantity = currentQuantity + product.stock;
    // clamp: batasi nilai antara 1 dan maxQuantity.
    final nextQuantity = quantity.clamp(1, maxQuantity);
    setState(() {
      // stock disesuaikan: kalau quantity turun, stock naik, dan sebaliknya.
      product.stock += currentQuantity - nextQuantity;
      cartQuantities[product.id] = nextQuantity;
    });
  }

  // removeFromCart: dipanggil saat user klik tombol hapus di CartProductCard.
  // Fungsinya:
  //  - kembalikan stock produk sebanyak quantity yang ada di keranjang.
  //  - hapus produk dari cartQuantities.
  // Dibungkus setState karena mengubah state.
  void removeFromCart(Product product) {
    final quantity = cartQuantities[product.id] ?? 0;
    if (quantity == 0) return;
    setState(() {
      // stock dikembalikan ke semula.
      product.stock += quantity;
      // hapus dari keranjang.
      cartQuantities.remove(product.id);
    });
  }

  // grandTotal: hitung total harga semua produk di keranjang.
  int get grandTotal => products.fold(0, (total, product) {
    return total + product.price * (cartQuantities[product.id] ?? 0);
  });

  // openCart: helper untuk push ke CartPage dengan semua data yang dibutuhkan.
  void openCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          products: products,
          cartQuantities: cartQuantities,
          onQuantityChanged: changeQuantity,
          onRemove: removeFromCart,
          onCheckout: () async {
            // Hitung grand total DULU sebelum clear.
            final total = grandTotal;
            // Push TotalPage, tunggu sampai user balik.
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TotalPage(grandTotal: total),
              ),
            );
            if (context.mounted) {
              setState(() {
                cartQuantities.clear();
              });
              Navigator.pop(context);
              openCart(context);
            }
          },
          onOpenCart: () => openCart(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = products.where((product) {
      return product.name.toLowerCase().contains(searchQuery);
    }).toList();

    // Scaffold: struktur dasar halaman (body + bottomNavigationBar).
    return Scaffold(
      backgroundColor:
          AppColors.background, // backgroundColor: warna latar halaman.
      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // SingleChildScrollView: agar halaman bisa di-scroll.
        child: SingleChildScrollView(
          // Column: susun hero & konten vertikal.
          child: Column(
            children: [
              _buildHeroSection(), // hero: bagian atas halaman.
              // Padding: jarak konten dari tepi layar.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                // Column: susun seluruh section vertikal.
                child: Column(
                  // crossAxisAlignment: rata kiri konten.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromoBanner(), // promo: kartu diskon.
                    // SizedBox: jarak antar section.
                    const SizedBox(height: 24),
                    // judul section kategori (dengan "Lihat Semua").
                    _buildSectionTitle('Kategori Alat Lab', showAction: true),
                    const SizedBox(height: 14),
                    _buildCategoryRow(), // baris kategori.
                    const SizedBox(height: 24),
                    // judul section produk (tanpa "Lihat Semua").
                    _buildSectionTitle('Produk Populer', showAction: false),
                    const SizedBox(height: 14),
                    _buildProductList(visibleProducts), // list produk populer.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: navigasi bawah
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // hero
  Widget _buildHeroSection() {
    // Container: latar navy besar di atas halaman.
    return Container(
      // width: lebar penuh.
      width: double.infinity,
      // padding: jarak isi dari tepi.
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
        // crossAxisAlignment: rata kiri.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: profil (kiri) & notifikasi (kanan).
          Row(
            // mainAxisAlignment: kasih jarak antar ujung.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row: avatar + nama.
              Row(
                children: [
                  // Container: avatar bulat
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    // Icon: ikon pengguna
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Column: label & nama vertikal
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text: label status
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
                      // Row: nama + ikon verified
                      Row(
                        children: const [
                          // Text: nama pengguna
                          Text(
                            'Nabilah Alfa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          // Icon: simbol terverifikasi
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
              // Container: tombol bulat notifikasi
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.white12,
                  borderRadius: BorderRadius.circular(999),
                ),
                // Row: ikon lonceng + titik merah
                child: Row(
                  // mainAxisAlignment: center
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon: ikon lonceng
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    // Container: titik merah notifikasi
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
          // Text: judul hero 1
          const Text(
            'Temukan Kebutuhan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text: judul hero 2
          const Text(
            'Laboratorium Anda',
            style: TextStyle(
              color: AppColors.accentLight,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _buildSearchBar(), // search bar
        ],
      ),
    );
  }

  // search bar
  Widget _buildSearchBar() {
    // Container: bungkus seluruh search bar
    return Container(
      // padding: jarak isi
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // BoxDecoration: warna & radius
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      // Row: ikon kaca pembesar + TextField + tombol filter
      child: Row(
        children: [
          // Icon: ikon kaca pembesar
          const Icon(Icons.search_rounded, color: AppColors.textGrey, size: 20),
          const SizedBox(width: 10),
          // Expanded: TextField mengisi sisa ruang
          Expanded(
            // TextField: input pencarian
            // onChanged: tiap user ngetik, update searchQuery lewat setState.
            child: TextField(
              onChanged: (value) =>
                  setState(() => searchQuery = value.toLowerCase()),
              // InputDecoration: hanya hint & border none
              decoration: InputDecoration(
                hintText:
                    'Cari alat, bahan, atau reagen...', // seperti placeholder
                hintStyle: const TextStyle(
                  color: AppColors.textGrey70,
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          // Container: tombol filter kotak navy
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(12),
            ),
            // Icon: ikon filter
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
    // Container: kartu promo utama
    return Container(
      // width: lebar penuh
      width: double.infinity,
      // padding: jarak isi
      padding: const EdgeInsets.all(20),
      // BoxDecoration: warna & radius
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(28),
      ),
      // Row: teks promo (kiri) + ikon (kanan)
      child: Row(
        children: [
          // Expanded: teks promo isi sisa ruang
          Expanded(
            // Column: susun teks promo vertikal
            child: Column(
              // crossAxisAlignment: rata kiri
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row: titik + label promo
                Row(
                  children: const [
                    // Icon: titik penanda promo
                    Icon(Icons.circle, color: AppColors.accentLight, size: 8),
                    SizedBox(width: 6),
                    // Text: label promo
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
                // Text: judul promo
                const Text(
                  'Diskon 20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Text: deskripsi promo
                const Text(
                  'Untuk semua alat gelas laboratorium\nminggu ini saja.',
                  style: TextStyle(color: AppColors.white70, fontSize: 12),
                ),
                const SizedBox(height: 14),
                // Container: pil info batas waktu
                Container(
                  // padding: jarak isi pil
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // Row: ikon jam + teks
                  child: Row(
                    // mainAxisSize: min biar pil gak lebar.
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      // Icon: ikon jam
                      Icon(
                        Icons.schedule_rounded,
                        color: AppColors.accentLight,
                        size: 13,
                      ),
                      SizedBox(width: 6),
                      // Text: keterangan waktu
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
          // Container: kotak bulat ikon labu
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: AppColors.accentLight18,
              borderRadius: BorderRadius.circular(20),
            ),
            // Icon: ilustrasi labu
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
    // Row: judul (kiri) + "Lihat Semua" (kanan)
    return Row(
      // mainAxisAlignment: kasih jarak antar ujung
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text: judul section
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        // showAction: kalau true tampil "Lihat Semua", kalau false kosong
        showAction
            // Row: teks + ikon panah
            ? Row(
                children: const [
                  // Text: tautan lihat semua
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Icon: panah
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.blue,
                    size: 16,
                  ),
                ],
              )
            // SizedBox: kosong kalau showAction false
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

      // Column: ikon di atas label
      items.add(
        Column(
          children: [
            // Container: lingkaran biru muda ikon kategori
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(999),
              ),
              // Icon: simbol kategori
              child: Icon(cat.icon, color: AppColors.blue, size: 24),
            ),
            const SizedBox(height: 6),
            // Text: nama kategori
            Text(
              cat.label,
              style: const TextStyle(fontSize: 11, color: AppColors.textDark),
            ),
          ],
        ),
      );
    }

    // Row: 4 kategori berjejer horizontal
    return Row(
      // mainAxisAlignment: kasih jarak antar kategori
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  // produk
  // Parameter visibleProducts: hasil filter dari build().
  Widget _buildProductList(List<Product> visibleProducts) {
    // list penampung kartu produk
    List<Widget> items = [];

    // loop produk
    for (int i = 0; i < visibleProducts.length; i++) {
      Product product = visibleProducts[i];

      // Padding: jarak bawah antar kartu
      items.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          // ProductCard: kartu produk
          // onAddToCart: callback ke addToCart di state ini.
          child: ProductCard(
            product: product,
            onAddToCart: () => addToCart(product),
          ),
        ),
      );
    }

    // Column: kartu produk vertikal
    return Column(children: items);
  }

  // bottom nav
  Widget _buildBottomNav(BuildContext context) {
    // Padding: jarak nav dari tepi layar
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      // Container: pil navy pembungkus menu navigasi
      child: Container(
        // padding: jarak isi pil
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // BoxDecoration: warna, radius, border
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.blue40),
        ),
        // Row: 4 menu navigasi horizontal
        child: Row(
          // mainAxisAlignment: bagi rata
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Beranda: menu aktif, tanpa aksi
            _navItem(Icons.home_rounded, 'Beranda', true, () {}),
            _navItem(Icons.biotech_rounded, 'Kategori', false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryPage(onOpenCart: () => openCart(context)),
                ),
              );
            }),
            _navItem(Icons.inventory_2_outlined, 'Pesanan', false, () {
              openCart(context);
            }),
            _navItem(Icons.person_outline_rounded, 'Profil', false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(onOpenCart: () => openCart(context)),
                ),
              );
            }),
          ],
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
    // ElevatedButton: tombol menu navigasi
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
        // padding: jarak isi pil.
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        // BoxDecoration: warna & radius
        decoration: BoxDecoration(
          color: active ? AppColors.accentLight15 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        // Column: ikon di atas label
        child: Column(
          // mainAxisSize: min biar gak lebar
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon: ikon menu
            Icon(
              icon,
              color: active ? AppColors.accentLight : AppColors.white60,
              size: 20,
            ),
            const SizedBox(height: 3),
            // Text: nama menu
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
      ),
    );
  }
}
