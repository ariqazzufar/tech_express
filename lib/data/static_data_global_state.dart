import 'package:flutter/material.dart';
import '../models/product.dart';

// Class sederhana untuk menyimpan state global (Simulasi session/database)
class AppData {
  static bool isVoucherClaimed = false;
  static String userName = "Ariq Az Zufar";
  static String userEmail = "ariq@example.com";
}

// Data produk statis untuk contoh e-commerce
final List<Product> mockProducts = [
  Product(
    id: 'p1',
    name: 'Smartphone X',
    price: 2499000,
    category: 'Smartphone',
    description: 'Smartphone terbaru dengan layar AMOLED 6.5 inci, RAM 8GB, dan baterai tahan lama.',
    icon: Icons.smartphone,
    stock: 25,
  ),
  Product(
    id: 'p2',
    name: 'Laptop Pro 14',
    price: 7999000,
    category: 'Laptop',
    description: 'Laptop performa tinggi untuk programming dan desain. Prosesor octa-core, SSD 512GB.',
    icon: Icons.laptop_mac,
    stock: 10,
  ),
  Product(
    id: 'p3',
    name: 'Wireless Headset Z',
    price: 299000,
    category: 'Audio',
    description: 'Headset bluetooth dengan fitur Noise Cancelling aktif dan bass yang dalam.',
    icon: Icons.headset_mic,
    stock: 50,
  ),
  Product(
    id: 'p4',
    name: 'Mechanical Keyboard',
    price: 450000,
    category: 'Accessories',
    description: 'Keyboard mekanikal RGB dengan switch biru yang tactile dan nyaman untuk mengetik.',
    icon: Icons.keyboard,
    stock: 15,
  ),
  Product(
    id: 'p5',
    name: 'Gaming Mouse',
    price: 175000,
    category: 'Accessories',
    description: 'Mouse gaming ergonomis dengan DPI yang dapat diatur dan lampu RGB.',
    icon: Icons.mouse,
    stock: 30,
  ),
  Product(
    id: 'p6',
    name: 'Tablet Lite 10"',
    price: 1899000,
    category: 'Smartphone',
    description: 'Tablet 10 inci yang cocok untuk belajar online dan menonton film.',
    icon: Icons.tablet_mac,
    stock: 12,
  ),
];

// Helper function untuk format Rupiah tanpa package tambahan
String formatRupiah(int number) {
  String numStr = number.toString();
  String result = '';
  int count = 0;
  for (int i = numStr.length - 1; i >= 0; i--) {
    result = '${numStr[i]}$result';
    count++;
    if (count % 3 == 0 && i > 0) {
      result = '.$result';
    }
  }
  return 'Rp$result';
}