import 'package:flutter/material.dart';

// Model data untuk Produk
class Product {
  final String id;
  final String name;
  final int price;
  final String category;
  final String description;
  final IconData icon; // Menggunakan Icon bawaan agar tidak perlu asset gambar untuk project sederhana
  final int stock;
  final int discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.icon,
    required this.stock,
    this.discount = 0,
  });
}
