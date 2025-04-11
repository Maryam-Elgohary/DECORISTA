import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  // A static variable to hold the singleton instance
  static final SupabaseManager _instance = SupabaseManager._internal();
  late final SupabaseClient _client;

  // Factory constructor to return the singleton instance
  factory SupabaseManager() {
    return _instance;
  }

  // Private constructor to initialize the SupabaseClient
  // The constructor is declared as private, which means that only the Singleton class can create an instance of this class
  SupabaseManager._internal() {
    _client = Supabase.instance.client; // Use the initialized Supabase client
  }

  // Getter to access the SupabaseClient
  SupabaseClient get client => _client;
}
