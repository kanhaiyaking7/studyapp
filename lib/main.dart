
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hi/features/auth/pages/Username.dart';
import 'package:supabase_flutter/supabase_flutter.dart';




import 'package:hi/pages/Navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://vwpuplztcmyhtzlzbylf.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ3cHVwbHp0Y215aHR6bHpieWxmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxODkzMTksImV4cCI6MjA3MDc2NTMxOX0.ep1B5cJBOfIAn1ll7KOvB_WwXMnyp1NFFk_f0EQp248');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child:    MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: UserName(),
        ));

  }
}
