import 'package:flutter/material.dart';
import 'package:it_way_bd_task/widgets/post_card_item.dart';

import 'core/di/dependency_injection.dart';
import 'data/models/Post_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'It Way Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'It Way Task Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Dummy posts list
  final List<PostModel> posts = [
    PostModel(
      userId: 1,
      id: 1,
      title: "First Post",
      body: "This is the body of the first post.",
    ),
    PostModel(
      userId: 2,
      id: 2,
      title: "Second Post",
      body: "This is the body of the second post.",
    ),
    PostModel(
      userId: 3,
      id: 3,
      title: "Third Post",
      body: "This is the body of the third post.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add, size: 24, color: Colors.white),
        label: const Text(
          "Add Post",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white, // Force text color white
          ),
        ),
      ),
    );
  }
}
