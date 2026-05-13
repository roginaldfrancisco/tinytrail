import 'package:cloud_firestore/cloud_firestore.dart';

class SeedData {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> seedModules() async {
    final List<Map<String, dynamic>> modules = [
      for (int i = 0; i < 10; i++)
        _createModule(
          'Letter ${String.fromCharCode(65 + i)}',
          'Letters',
          'Learn the beautiful letter ${String.fromCharCode(65 + i)} with fun examples!',
          'https://picsum.photos/id/${100 + i}/800/600',
        ),

      for (int i = 1; i <= 10; i++)
        _createModule(
          'Number $i',
          'Numbers',
          "Let's count and play with number $i!",
          'https://picsum.photos/id/${200 + i}/800/600',
        ),

      for (int i = 0; i < 10; i++)
        _createModule(
          ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange', 'Pink', 'Brown', 'Black', 'White'][i],
          'Colors',
          'Discover the wonderful color ${['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange', 'Pink', 'Brown', 'Black', 'White'][i]}!',
          'https://picsum.photos/id/${300 + i}/800/600',
        ),

      for (int i = 0; i < 10; i++)
        _createModule(
          ['Circle', 'Square', 'Triangle', 'Rectangle', 'Star', 'Heart', 'Oval', 'Diamond', 'Pentagon', 'Hexagon'][i],
          'Shapes',
          'Learn about the ${['Circle', 'Square', 'Triangle', 'Rectangle', 'Star', 'Heart', 'Oval', 'Diamond', 'Pentagon', 'Hexagon'][i]} shape!',
          'https://picsum.photos/id/${400 + i}/800/600',
        ),

      for (int i = 0; i < 10; i++)
        _createModule(
          ['Dog', 'Cat', 'Lion', 'Elephant', 'Monkey', 'Rabbit', 'Bird', 'Fish', 'Butterfly', 'Tiger'][i],
          'Animals',
          'Meet the amazing ${['Dog', 'Cat', 'Lion', 'Elephant', 'Monkey', 'Rabbit', 'Bird', 'Fish', 'Butterfly', 'Tiger'][i]}!',
          'https://picsum.photos/id/${500 + i}/800/600',
        ),

      for (int i = 0; i < 10; i++)
        _createModule(
          ['Apple', 'Banana', 'Carrot', 'Strawberry', 'Broccoli', 'Orange', 'Grapes', 'Tomato', 'Pineapple', 'Watermelon'][i],
          'Fruits & Vegetables',
          'Yummy! Today we learn about ${['Apple', 'Banana', 'Carrot', 'Strawberry', 'Broccoli', 'Orange', 'Grapes', 'Tomato', 'Pineapple', 'Watermelon'][i]}',
          'https://picsum.photos/id/${600 + i}/800/600',
        ),

      for (int i = 0; i < 10; i++)
        _createModule(
          ['Hands', 'Eyes', 'Nose', 'Mouth', 'Ears', 'Feet', 'Legs', 'Arms', 'Hair', 'Head'][i],
          'Body Parts',
          "Let's learn about our ${['Hands', 'Eyes', 'Nose', 'Mouth', 'Ears', 'Feet', 'Legs', 'Arms', 'Hair', 'Head'][i]}",
          'https://picsum.photos/id/${700 + i}/800/600',
        ),
    ];

    for (var module in modules) {
      await _db.collection('modules').doc(module['lessonId']).set(module);
    }
  }

  static Map<String, dynamic> _createModule(String title, String category, String description, String mediaUrl) {
    final String id = '${category.toLowerCase()}_${title.toLowerCase().replaceAll(' ', '')}';
    return {
      'lessonId': id,
      'title': title,
      'description': description,
      'category': category,
      'content_type': 'image_text',
      'media_url': mediaUrl,
      'difficulty_level': 'easy',
      'estimated_duration': 3,
    };
  }
}