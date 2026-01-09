import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'cots/config/app_constants.dart';
import 'cots/controllers/recipe_controller.dart';
import 'cots/presentation/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase [cite: 143-146]
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Register Controller agar bisa diakses di semua halaman
        ChangeNotifierProvider(create: (_) => RecipeController()..fetchRecipes()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Resep App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const DashboardPage(),
      ),
    );
  }
}