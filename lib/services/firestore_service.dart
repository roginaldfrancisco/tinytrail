import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/module_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ModuleModel>> getModules() {
    return _db.collection('modules').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ModuleModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<List<ModuleModel>> getModulesByCategory(String category) async {
    final snapshot = await _db
        .collection('modules')
        .where  ('category', isEqualTo: category)
        .get();

    return snapshot.docs.map((doc) {
      return ModuleModel.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  Future<ModuleModel?> getModuleById(String lessonId) async {
    final doc = await _db.collection('modules').doc(lessonId).get();
    if (doc.exists) {
      return ModuleModel.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }
}