import 'package:flutter/material.dart';

import 'category_page.dart';

// ProfilePage: halaman profil pengguna.
class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.onOpenCart, super.key});

  final VoidCallback onOpenCart;

  // Data dummy menu profil.
  final List<Map<String, dynamic>> menuItems = const [
    {
      'icon': Icons.person_outline_rounded,
      'label': 'Edit Profil',
      'sub': 'Nama, email, nomor telepon',
    },
    {
      'icon': Icons.location_on_outlined,
      'label': 'Alamat Pengiriman',
      'sub': 'Kelola alamat pengiriman',
    },
    {
      'icon': Icons.receipt_long_outlined,
      'label': 'Riwayat Pesanan',
      'sub': 'Lihat semua transaksi',
    },
    {
      'icon': Icons.notifications_none_rounded,
      'label': 'Notifikasi',
      'sub': 'Atur preferensi notifikasi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman.
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),

      // SafeArea: konten tidak tertutup notch/status bar.
      body: SafeArea(
        // SingleChildScrollView: halaman bisa di-scroll.
        child: SingleChildScrollView(
          // Column: susun header profil + menu vertikal.
          child: Column(
            children: [
              // Container: header profil dengan latar navy.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F1C2C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                // Column: tombol back, avatar, nama, institusi.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row: tombol back + judul.
                    Row(
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
                              color: const Color(0x1FFFFFFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text: judul halaman.
                        const Text(
                          'Profil Saya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Row: avatar + nama + institusi.
                    Row(
                      children: [
                        // Container: avatar bulat.
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0x1FFFFFFF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          // Icon: ikon pengguna.
                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Expanded: teks nama & institusi.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text: nama pengguna.
                              const Text(
                                'Nabilah Alfa',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Text: institusi.
                              const Text(
                                'Central BioLab Institute',
                                style: TextStyle(
                                  color: Color(0xB3FFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Padding: jarak menu dari tepi layar.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // Column: susun kartu menu vertikal.
                child: Column(
                  children: menuItems.map((item) {
                    // Padding: jarak bawah antar kartu.
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      // Container: kartu menu.
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
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
                        // Row: ikon + teks + panah.
                        child: Row(
                          children: [
                            // Container: lingkaran biru muda ikon menu.
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4E4FC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              // Icon: simbol menu.
                              child: Icon(
                                item['icon'] as IconData,
                                color: const Color(0xFF1960A3),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Expanded: teks menu.
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text: label menu.
                                  Text(
                                    item['label'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181C1F),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  // Text: deskripsi menu.
                                  Text(
                                    item['sub'] as String,
                                    style: const TextStyle(
                                      fontSize: 11,
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

              const SizedBox(height: 8),

              // Padding: jarak tombol keluar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // ElevatedButton: tombol keluar (nonaktif)
                child: ElevatedButton(
                  onPressed: null, // null: tombol tidak bisa ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFFFDAD6,
                    ),
                    disabledBackgroundColor: const Color(
                      0xFFFFDAD6,
                    ),
                    foregroundColor: const Color(
                      0xFFBA1A1A,
                    ),
                    disabledForegroundColor: const Color(
                      0x66BA1A1A,
                    ),
                    elevation: 0, // elevation: rata
                    minimumSize: const Size(
                      double.infinity,
                      48,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // radius: 16
                    ),
                  ),
                  // Row: ikon + label
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon: ikon logout
                      Icon(Icons.logout_rounded, size: 18),
                      SizedBox(width: 8),
                      // Text: label tombol
                      Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
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
              _navItem(Icons.biotech_rounded, 'Kategori', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryPage(onOpenCart: onOpenCart),
                  ),
                );
              }),
              // Pesanan: panggil onOpenCart (callback dari HomePage).
              _navItem(Icons.inventory_2_outlined, 'Pesanan', false, () {
                onOpenCart();
              }),
              // Profil: menu aktif
              _navItem(Icons.person_outline_rounded, 'Profil', true, () {}),
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