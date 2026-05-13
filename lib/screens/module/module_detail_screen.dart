import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../../services/local_storage_service.dart';

class ModuleDetailScreen extends StatefulWidget {
  final ModuleModel module;
  const ModuleDetailScreen({super.key, required this.module});

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  final LocalStorageService _localService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _saveLastOpened();
  }

  Future<void> _saveLastOpened() async {
    await _localService.saveLastOpenedModule(widget.module.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.title),
        actions: [
          IconButton(
            icon: Icon(
              favoritesProvider.isFavorite(widget.module.lessonId)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              favoritesProvider.toggleFavorite(widget.module.lessonId);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.module.mediaUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image_not_supported, size: 80)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title & Info
            Text(
              widget.module.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(widget.module.difficultyLevel)),
                const SizedBox(width: 12),
                Chip(label: Text('${widget.module.estimatedDuration} min')),
              ],
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              'What you will learn:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              widget.module.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}