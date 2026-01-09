import 'package:flutter/material.dart';
import '../../design_system/app_colors.dart';
import '../../design_system/app_typography.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final String category;

  const RecipeDetailPage({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Background luar abu-abu muda
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FD), // Samakan dengan background
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Resep",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: AppTypography.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // 1. KONTEN UTAMA (Scrollable)
          SingleChildScrollView(
            // Padding bawah besar agar konten tidak tertutup tombol fixed
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100), 
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white, // Kartu Putih
                borderRadius: BorderRadius.all(Radius.circular(20)), // Radius semua sisi
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Resep
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Kategori
                  Text(
                    "Kategori: $category",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.muted, // Warna abu-abu agar tidak terlalu mencolok
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section: Bahan-bahan
                  const Text(
                    "Bahan-bahan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // List Bahan (Hardcoded sesuai gambar agar rapi)
                  _buildIngredientRow("Nasi Putih (2 piring)"),
                  _buildIngredientRow("Telur (2 butir)"),
                  _buildIngredientRow("Bawang Merah (3 siung)"),
                  _buildIngredientRow("Kecap Manis (2 sdm)"),
                  _buildIngredientRow("Kecap Asin (1 sdm)"), // Tambahan biar pas layout

                  const SizedBox(height: 24),

                  // Section: Langkah-langkah
                  const Text(
                    "Langkah-langkah",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Panaskan minyak, tumis bumbu halus,\n"
                    "Masukkan nasi dan bahan lain,\n"
                    "Masak hingga matang.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.8, // Spasi antar baris agar mudah dibaca
                      color: Color(0xFF334155),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section: Catatan (Box Abu-abu)
                  const Text(
                    "Catatan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9), // Warna abu-abu sangat muda (Slate 100)
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Tambahkan kerupuk untuk pelengkap.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. FOOTER TOMBOL (Fixed Position)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4), // Bayangan ke atas
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E64DD), // Warna Biru Utama
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Simpan ke Favorit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk item bahan agar rapi
  Widget _buildIngredientRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF334155),
        ),
      ),
    );
  }
}