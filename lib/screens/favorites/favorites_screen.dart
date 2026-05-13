import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../../services/firestore_service.dart';
import '../../models/module_model.dart';
import '../module/module_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<ModuleModel> _favoriteModules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteModules();
  }

  Future<void> _loadFavoriteModules() async {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final favIds = favoritesProvider.favorites;

    List<ModuleModel> loaded = [];
    for (String id in favIds) {
      final module = await _firestoreService.getModuleById(id);
      if (module != null) loaded.add(module);
    }

    setState(() {
      _favoriteModules = loaded;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteModules.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _favoriteModules.length,
        itemBuilder: (context, index) {
          final module = _favoriteModules[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text(module.title),
              subtitle: Text(module.category),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ModuleDetailScreen(module: module),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}