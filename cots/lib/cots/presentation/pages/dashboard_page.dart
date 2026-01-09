import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../design_system/app_colors.dart';
import '../../design_system/app_typography.dart';
import '../widgets/recipe_card.dart';
import 'recipe_list_page.dart';
import 'add_recipe_page.dart';
import '../../controllers/recipe_controller.dart'; // Import Controller

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Memanggil data saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeController>().fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Stack(
          children: [
            // Gunakan Consumer untuk mendengarkan perubahan data
            Consumer<RecipeController>(
              builder: (context, controller, child) {
                // Tampilan Loading jika data sedang diambil
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Resep Masakan",
                            style: AppTypography.title.copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecipeListPage()),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerRight,
                            ),
                            child: Text(
                              "Daftar Resep",
                              style: AppTypography.body.copyWith(
                                color: AppColors.muted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 2. Statistik Grid (DATA DINAMIS) 
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildStatCard(
                            title: "Total Resep",
                            count: controller.totalRecipes
                                .toString(), // Ambil dari Controller
                            color: AppColors.primary,
                          ),
                          _buildStatCard(
                            title: "Sarapan",
                            count: controller.countSarapan
                                .toString(), // Ambil dari Controller
                            color: Colors.orangeAccent,
                          ),
                          _buildStatCard(
                            title: "Makan Siang & Malam",
                            count: controller.countSiangMalam
                                .toString(), // Ambil dari Controller
                            color: Colors.green,
                            isSmallText: true,
                          ),
                          _buildStatCard(
                            title: "Dessert",
                            count: controller.countDessert
                                .toString(), // Ambil dari Controller
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 3. Section Title: Resep Terbaru
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Resep Terbaru",
                            style: AppTypography.section.copyWith(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecipeListPage()),
                              );
                            },
                            child: Text(
                              "Lihat Semua",
                              style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 4. List Resep (DATA DINAMIS)
                      if (controller.recipes.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Belum ada resep. Tambahkan sekarang!"),
                        )
                      else
                        // Menampilkan 5 resep terbaru saja di Dashboard
                        ...controller.recipes.take(5).map((recipe) {
                          return RecipeCard(
                            title: recipe.title,
                            category: recipe.category,
                            // Durasi hardcode dulu karena tidak ada di field soal
                            duration: "30 Menit",
                            // Gambar placeholder random agar terlihat bagus
                            imageUrl:
                                "https://source.unsplash.com/random/300x200?food&sig=${recipe.id}",
                          );
                        }),
                    ],
                  ),
                );
              },
            ),

            // 5. Tombol Tambah Resep
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.3],
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddRecipePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E64DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF1E64DD).withOpacity(0.4),
                    ),
                    child: const Text(
                      "Tambah Resep Baru",
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
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
    bool isSmallText = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              fontSize: isSmallText ? 11 : 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: AppTypography.title.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}