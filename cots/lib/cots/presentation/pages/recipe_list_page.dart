import 'package:flutter/material.dart';
import '../../design_system/app_colors.dart';
import '../../design_system/app_typography.dart';
import '../widgets/recipe_card.dart';
import 'add_recipe_page.dart'; // Pastikan file ini sudah di-import

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Daftar Resep",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              // --- NAVIGASI KE HALAMAN TAMBAH RESEP ---
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddRecipePage()),
                );
              },
              child: Row(
                children: [
                  Text(
                    "Tambah",
                    style: AppTypography.body.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.add_circle_outline,
                      color: AppColors.primary, size: 20),
                ],
              ),
            ),
          )
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Cari resep atau bahan...",
                  hintStyle: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14), // Warna placeholder soft
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon:
                      Icon(Icons.search, color: Color(0xFF94A3B8)), // Icon di KANAN
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 2. Kategori Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                _buildFilterChip("Semua", isActive: true),
                _buildFilterChip("Sarapan"),
                _buildFilterChip("Makan Siang"),
                _buildFilterChip("Makan Malam"),
                _buildFilterChip("Dessert"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 3. List Resep
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                RecipeCard(
                  title: "Nasi Goreng Spesial",
                  category: "Sarapan",
                  duration: "20 Menit",
                  imageUrl:
                      "https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=300&q=80",
                ),
                RecipeCard(
                  title: "Ayam Bakar Madu",
                  category: "Makan Malam",
                  duration: "45 Menit",
                  imageUrl:
                      "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=300&q=80",
                ),
                RecipeCard(
                  title: "Soto Ayam Kuning",
                  category: "Makan Siang",
                  duration: "60 Menit",
                  imageUrl:
                      "https://images.unsplash.com/photo-1633436305098-9f2b98f2d6ce?auto=format&fit=crop&w=300&q=80",
                ),
                RecipeCard(
                  title: "Puding Coklat",
                  category: "Dessert",
                  duration: "10 Menit",
                  imageUrl:
                      "https://images.unsplash.com/photo-1549401002-e25f69741df7?auto=format&fit=crop&w=300&q=80",
                ),
                RecipeCard(
                  title: "Roti Bakar Keju",
                  category: "Sarapan",
                  duration: "10 Menit",
                  imageUrl:
                      "https://images.unsplash.com/photo-1584776296906-6af148e6c1e6?auto=format&fit=crop&w=300&q=80",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              border: isActive
                  ? null
                  : Border.all(color: const Color(0xFFE2E8F0)), // Border abu soft
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}