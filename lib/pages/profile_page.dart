import 'package:flutter/material.dart';
import '../data/product_data.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Fungsi Edit Profil
  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: AppData.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nama Baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                AppData.userName = nameController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF111827)),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Fungsi Logout
  void _logout() {
    // Navigasi kembali ke halaman login dan hapus semua history halaman
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profil
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF111827),
                    child: Icon(Icons.person, size: 60, color: Color(0xFFD4AF37)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppData.userName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppData.userEmail,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Demo User',
                      style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Menu Profil
            _buildMenuTile(Icons.edit, 'Edit Profil', _editProfile),
            _buildMenuTile(
              Icons.card_giftcard,
              'Voucher Saya',
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Voucher Saya'),
                    content: Text(AppData.isVoucherClaimed
                        ? 'Anda memiliki 1 Voucher Aktif (TECH10 - Diskon 10%)'
                        : 'Belum ada voucher yang diklaim.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
                  ),
                );
              },
            ),
            _buildMenuTile(
              Icons.info_outline,
              'Tentang TechExpress',
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Tentang TechExpress'),
                    content: const Text('TechExpress adalah aplikasi e-commerce sederhana yang dibuat untuk project sekolah SMK. Dibuat menggunakan Flutter.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
                  ),
                );
              },
            ),
            _buildMenuTile(
              Icons.help_outline,
              'Bantuan',
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Bantuan'),
                    content: const Text('Hubungi guru pembimbing Anda jika mengalami kesulitan dalam menjalankan project ini.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
                  ),
                );
              },
            ),
            const Divider(),
            _buildMenuTile(Icons.logout, 'Logout', _logout, isDestructive: true),
          ],
        ),
      ),
    );
  }

  // Widget bantuan untuk membuat menu tile
  Widget _buildMenuTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : const Color(0xFF111827)),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? Colors.red : const Color(0xFF111827)),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      tileColor: Colors.white,
    );
  }
}