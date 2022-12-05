import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_evox_app/views/screens/session_handler.dart';
import 'package:the_evox_app/views/screens/testing_repo.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: TheEvox()));
}

class TheEvox extends StatelessWidget {
  const TheEvox({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Evox',
      home: TestingrepoScreen(),
    );
  }
}
