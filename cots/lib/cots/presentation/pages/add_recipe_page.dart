import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../design_system/app_colors.dart';
import '../../design_system/app_typography.dart';
import '../../controllers/recipe_controller.dart'; // Import Controller
import '../../models/recipe.dart'; // Import Model

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // Controller untuk menangani input teks
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Variabel untuk Dropdown Kategori
  String? _selectedCategory;
  final List<String> _categories = [
    'Sarapan',
    'Makan Siang',
    'Makan Malam',
    'Dessert'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // --- FUNGSI SIMPAN DATA [cite: 187] ---
  Future<void> _saveRecipe() async {
    // 1. Validasi Input Sederhana
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul resep wajib diisi")),
      );
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kategori wajib dipilih")),
      );
      return;
    }

    // 2. Buat Objek Model Recipe
    final newRecipe = Recipe(
      title: _titleController.text,
      category: _selectedCategory!,
      ingredients: _ingredientsController.text,
      steps: _stepsController.text,
      note: _notesController.text,
      // id dan createdAt dibiarkan null (dihandle backend/supabase)
    );

    // 3. Panggil Controller
    final controller = context.read<RecipeController>();
    final success = await controller.addRecipe(newRecipe);

    if (!mounted) return;

    if (success) {
      // Jika berhasil, kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resep berhasil disimpan!")),
      );
      Navigator.pop(context);
    } else {
      // Jika gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: ${controller.errorMessage}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil status loading dari controller
    final isLoading = context.select<RecipeController, bool>((c) => c.isLoading);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text(
          "Tambah Resep",
          style: AppTypography.title
              .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 1. AREA FORM (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                      children: [
                        // --- Input Judul Resep ---
                        _buildLabel("Judul Resep"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _titleController,
                          decoration: _inputDecoration(
                            hintText: "Masukan judul resep",
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- Dropdown Kategori ---
                        _buildLabel("Kategori"),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: _inputDecoration(hintText: "Pilih Kategori"),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category, style: AppTypography.body),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // --- Input Bahan-bahan ---
                        _buildLabel("Bahan-bahan"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _ingredientsController,
                          maxLines: 3,
                          decoration: _inputDecoration(
                            hintText: "Masukkan bahan, pisahkan dengan koma...",
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- Input Langkah-langkah ---
                        _buildLabel("Langkah-langkah"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _stepsController,
                          maxLines: 3,
                          decoration: _inputDecoration(
                            hintText:
                                "Masukkan langkah, pisahkan dengan baris baru...",
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- Input Catatan ---
                        _buildLabel("Catatan"),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _notesController,
                          maxLines: 2,
                          decoration: _inputDecoration(
                            hintText: "Catatan tambahan (opsional)",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. AREA TOMBOL (Fixed Bottom)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Tombol Batal
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Batal",
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Tombol Simpan
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveRecipe, // Disable jika loading
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E64DD),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Text(
                                "Simpan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Overlay loading opsional jika ingin memblokir seluruh layar
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.body.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hintText, String? errorText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1E64DD), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      errorText: errorText,
    );
  }
}