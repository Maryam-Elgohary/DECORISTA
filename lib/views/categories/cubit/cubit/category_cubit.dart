import 'package:bloc/bloc.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  // Reference to SupabaseManager Singleton
  final _supabase = SupabaseManager();

  // Subscription to real-time changes
  RealtimeChannel? _realtimeChannel;
  /// Fetches initial categories from Supabase.
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final response = await _supabase.client.from('category_table').select();

      // Transform response into a list of categories
      final List<Map<String, dynamic>> categories =
          (response as List).map((item) {
        return {
          'id': item['category_id'],
          'name': item['category_name'],
          'image_url': item['image_url'] ?? '',
        };
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }

  /// Subscribes to real-time changes in the category_table.
  void subscribeToCategories() {
    // Unsubscribe from any existing subscription to avoid duplicates
    unsubscribe();

    // Set up real-time subscription
    _realtimeChannel = _supabase.client
        .channel('public:category_table')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'category_table',
          callback: (payload) {
            // When a change occurs, fetch categories again or update incrementally
            _handleRealtimeUpdate(payload);
          },
        )
        .subscribe();

    // Fetch initial data when subscribing
    fetchCategories();
  }

  /// Handles real-time updates from Supabase.
  void _handleRealtimeUpdate(PostgresChangePayload payload) {
    // For simplicity, refetch all categories on any change
    // In a production app, you could update the list incrementally
    fetchCategories();
  }

  /// Unsubscribes from real-time updates.
  void unsubscribe() {
    if (_realtimeChannel != null) {
      _supabase.client.removeChannel(_realtimeChannel!);
      _realtimeChannel = null;
    }
  }

  @override
  Future<void> close() {
    // Clean up subscription when cubit is closed
    unsubscribe();
    return super.close();
  }
}

