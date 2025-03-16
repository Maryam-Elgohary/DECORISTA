import 'package:flutter/material.dart';
import 'package:furniture_app/views/onboarding_screens/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wdgpfhefvzknfoeaxizj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndkZ3BmaGVmdnprbmZvZWF4aXpqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxNTE4MDIsImV4cCI6MjA1NzcyNzgwMn0.KofLq38MhNTh5eI8ZCas6xcTVSM1ZIZTJZqZIm7WUM4',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: OnBoarding());
  }
}
