import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://cicnbomtiugezyukwnls.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpY25ib210aXVnZXp5dWt3bmxzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE2MzM4NTgsImV4cCI6MjA3NzIwOTg1OH0.30oIDvhWg8nbtF2rWOhq4WdaKRm9L1I2YayJR_oFvdY';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      // AJOUTEZ ces options pour plus de stabilité
      // authFlowType: AuthFlowType.pkce,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
