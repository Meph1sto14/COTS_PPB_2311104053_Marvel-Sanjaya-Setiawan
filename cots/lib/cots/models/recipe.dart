class Recipe {
  final int? id; // Ubah jadi nullable agar tidak error saat Insert (ID auto-generate)
  final String title;
  final String category;
  final String ingredients;
  final String steps;
  final String note;
  final String? createdAt; // Nullable

  Recipe({
    this.id,
    required this.title,
    required this.category,
    required this.ingredients,
    required this.steps,
    required this.note,
    this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      note: json['note'] ?? '',
      createdAt: json['created_at'],
    );
  }

  // Tambahkan ini untuk kirim data ke Supabase
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'ingredients': ingredients,
      'steps': steps,
      'note': note,
    };
  }
}