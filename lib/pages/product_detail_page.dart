import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/product_data.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  // Menerima data produk dari halaman sebelumnya
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  bool _useVoucher = false;

  void _increaseQty() {
    if (_quantity < widget.product.stock) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQty() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  // Menampilkan dialog simulasi pembelian
  void _buyNow() {
    int basePrice = widget.product.price * _quantity;
    int discount = _useVoucher ? (basePrice * 0.1).round() : 0;
    int finalPrice = basePrice - discount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembelian'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produk: ${widget.product.name}'),
            Text('Jumlah: $_quantity unit'),
            if (_useVoucher) Text('Diskon: -${formatRupiah(discount)} (TECH10)'),
            const Divider(),
            Text(
              'Total Bayar: ${formatRupiah(finalPrice)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pembelian berhasil! (Simulasi)')),
              );
              Navigator.pop(context); // Kembali ke home
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF111827)),
            child: const Text('Bayar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int basePrice = widget.product.price * _quantity;
    int discount = _useVoucher ? (basePrice * 0.1).round() : 0;
    int finalPrice = basePrice - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk (Icon)
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Icon(widget.product.icon, size: 100, color: const Color(0xFF111827)),
              ),
            ),
            const SizedBox(height: 24),

            // Kategori & Nama
            Text(
              widget.product.category.toUpperCase(),
              style: const TextStyle(color: Colors.grey, letterSpacing: 1.2, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 8),

            // Harga
            Text(
              formatRupiah(widget.product.price),
              style: const TextStyle(fontSize: 22, color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Deskripsi
            const Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(widget.product.description, style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 16),
            Text('Stok tersedia: ${widget.product.stock}', style: const TextStyle(color: Colors.grey)),
            const Divider(height: 40),

            // Voucher Checkbox (Hanya muncul jika sudah diklaim di Home)
            if (AppData.isVoucherClaimed)
              CheckboxListTile(
                title: const Text('Gunakan Voucher TECH10 (Diskon 10%)'),
                value: _useVoucher,
                activeColor: const Color(0xFF111827),
                onChanged: (bool? value) {
                  setState(() {
                    _useVoucher = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

            // Jumlah Pembelian
            Row(
              children: [
                const Text('Jumlah:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: _decreaseQty, icon: const Icon(Icons.remove_circle_outline)),
                Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(onPressed: _increaseQty, icon: const Icon(Icons.add_circle_outline)),
              ],
            ),
            const SizedBox(height: 16),

            // Info Harga Akhir
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  if (_useVoucher) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Harga Awal:'),
                        Text(formatRupiah(basePrice), style: const TextStyle(decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Potongan:', style: TextStyle(color: Colors.green)),
                        Text('-${formatRupiah(discount)}', style: const TextStyle(color: Colors.green)),
                      ],
                    ),
                    const Divider(),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(formatRupiah(finalPrice), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar khusus untuk tombol aksi
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dimasukkan ke keranjang!')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF111827)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Icon(Icons.shopping_cart, color: Color(0xFF111827)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: _buyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Beli Sekarang', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}