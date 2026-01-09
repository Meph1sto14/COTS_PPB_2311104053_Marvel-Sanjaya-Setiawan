import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeController extends ChangeNotifier {
  final RecipeService _service = RecipeService();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Mengambil data saat inisialisasi
  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _recipes = await _service.getRecipes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Menambah resep
  Future<bool> addRecipe(Recipe recipe) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.addRecipe(recipe);
      await fetchRecipes(); // Refresh data setelah tambah
      return true; // Berhasil
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false; // Gagal
    }
  }
  
  // Getter untuk Statistik Dashboard [cite: 19]
  int get totalRecipes => _recipes.length;
  int get countSarapan => _recipes.where((r) => r.category == 'Sarapan').length;
  int get countSiangMalam => _recipes.where((r) => r.category.contains('Makan')).length;
  int get countDessert => _recipes.where((r) => r.category == 'Dessert').length;
}