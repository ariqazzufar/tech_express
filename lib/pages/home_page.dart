import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _displayedProducts = [];

  @override
  void initState() {
    super.initState();
    _displayedProducts = mockProducts; // Tampilkan semua produk saat awal
  }

  // Fungsi untuk mencari produk
  void _searchProduct(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = mockProducts;
      } else {
        _displayedProducts = mockProducts
            .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Fungsi untuk mengklaim voucher
  void _claimVoucher() {
    setState(() {
      AppData.isVoucherClaimed = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voucher TECH10 berhasil diklaim!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechExpress', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              ).then((_) => setState(() {})); // Refresh UI jika nama diubah
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: _searchProduct,
                decoration: InputDecoration(
                  hintText: 'Cari produk teknologi...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),

              // Promo Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF111827), Color(0xFF374151)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Diskon Produk Teknologi',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Upgrade gadgetmu hari ini dengan harga terbaik.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Voucher Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.local_offer, color: Color(0xFFD4AF37)),
                  title: const Text('Voucher Diskon 10%'),
                  subtitle: const Text('Kode: TECH10'),
                  trailing: AppData.isVoucherClaimed
                      ? const Text('Diklaim', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                      : ElevatedButton(
                          onPressed: _claimVoucher,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF111827)),
                          child: const Text('Klaim', style: TextStyle(color: Colors.white)),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Judul Kategori
              const Text(
                'Kategori: Semua Produk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
              ),
              const SizedBox(height: 12),

              // Grid Produk
              _displayedProducts.isEmpty
                  ? const Center(child: Text('Produk tidak ditemukan.'))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Mematikan scroll grid agar ikut scroll induk
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: _displayedProducts[index]);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}