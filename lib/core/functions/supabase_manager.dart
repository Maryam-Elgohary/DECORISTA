import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseManager _instance = SupabaseManager._internal();
  late final SupabaseClient _client;

  // Factory constructor to return the singleton instance
  factory SupabaseManager() {
    return _instance;
  }

  // Private constructor to initialize the SupabaseClient
  SupabaseManager._internal() {
    _client = Supabase.instance.client; // Use the initialized Supabase client
  }

  // Getter to access the SupabaseClient
  SupabaseClient get client => _client;
}
