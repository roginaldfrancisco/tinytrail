import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/firestore_service.dart';
import '../../services/local_storage_service.dart';
import '../../models/module_model.dart';
import '../../utils/constants.dart';
import 'category_modules_screen.dart';
import '../module/module_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final LocalStorageService _localService = LocalStorageService();
  ModuleModel? _lastModule;
  bool _isLoading = true;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Letters', 'icon': Icons.abc, 'color': Colors.purple},
    {'name': 'Numbers', 'icon': Icons.format_list_numbered, 'color': Colors.blue},
    {'name': 'Colors', 'icon': Icons.palette, 'color': Colors.orange},
    {'name': 'Shapes', 'icon': Icons.category, 'color': Colors.green},
    {'name': 'Animals', 'icon': Icons.pets, 'color': Colors.brown},
    {'name': 'Fruits & Vegetables', 'icon': Icons.apple, 'color': Colors.red},
    {'name': 'Body Parts', 'icon': Icons.accessibility_new, 'color': Colors.teal},
  ];

  @override
  void initState() {
    super.initState();
    _loadLastOpened();
  }

  Future<void> _loadLastOpened() async {
    final id = await _localService.getLastOpenedModule();
    if (id != null) {
      final module = await _firestoreService.getModuleById(id);
      setState(() {
        _lastModule = module;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${user?['name'] ?? 'Little Explorer'}! 🐾',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.tagline,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Continue Where You Left Off
            if (_lastModule != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModuleDetailScreen(module: _lastModule!),
                    ),
                  );
                },
                child: Card(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.play_arrow, size: 40, color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Continue Learning', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(_lastModule!.title, style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),
            const Text('Explore Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Category Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryModulesScreen(category: cat['name']),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], size: 50, color: cat['color']),
                          const SizedBox(height: 12),
                          Text(
                            cat['name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}