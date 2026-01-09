import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';

class RecipeService {
  final SupabaseClient _client = Supabase.instance.client;

  // GET: Ambil semua resep [cite: 152]
  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await _client
          .from('recipes')
          .select('*')
          .order('created_at', ascending: false); // Urutkan dari yang terbaru

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil resep: $e');
    }
  }

  // POST: Tambah resep baru [cite: 176-189]
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _client.from('recipes').insert(recipe.toJson());
    } catch (e) {
      throw Exception('Gagal menambah resep: $e');
    }
  }
}