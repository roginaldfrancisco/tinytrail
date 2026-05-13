import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/module_model.dart';
import '../module/module_detail_screen.dart';

class CategoryModulesScreen extends StatefulWidget {
  final String category;
  const CategoryModulesScreen({super.key, required this.category});

  @override
  State<CategoryModulesScreen> createState() => _CategoryModulesScreenState();
}

class _CategoryModulesScreenState extends State<CategoryModulesScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<ModuleModel> _modules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  Future<void> _loadModules() async {
    final modules = await _firestoreService.getModulesByCategory(widget.category);
    setState(() {
      _modules = modules;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _modules.isEmpty
          ? const Center(child: Text('No modules found'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _modules.length,
        itemBuilder: (context, index) {
          final module = _modules[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.school, size: 40),
              title: Text(module.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${module.difficultyLevel} • ${module.estimatedDuration} min'),
              trailing: const Icon(Icons.arrow_forward_ios),
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